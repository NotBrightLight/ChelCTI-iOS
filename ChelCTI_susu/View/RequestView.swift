//
//  RequestView2.swift
//  ChelCTI_susu
//
//  Created by Артем Васин on 13.06.2022.
//

import SwiftUI
import QuickLook

struct RequestView: View {
    private enum FocusField {
        case name, phone, email, nothing
    }
    
    @EnvironmentObject var appState: AppState
    
    @StateObject private var requestVM = RequestVM()
    
    @State private var showFilePicker = false
    // Only one .fileImporter is allowed so we switch this var to append files to diff arrays
    @State private var pickerArray = 1
    
    @State private var showPreview = false
    @State private var urlForShow: URL? {
        didSet {
            showPreview = true
        }
    }
    
    @FocusState private var fieldFocus: FocusField?
    
    var body: some View {
        VStack {
            Form {
                SegmentedPicker(items: requestVM.pickerOptions, selection: $requestVM.selectedForm)
                
                // MARK: Форма
                
                Section("Контактная информация") {
                    TextField("ФИО", text: $requestVM.name)
                        .textContentType(.name)
                        .keyboardType(.namePhonePad)
                        .textInputAutocapitalization(.words)
                        .focused($fieldFocus, equals: .name)
                        .submitLabel(.next)
                    
                    TextField("Телефон", text: $requestVM.phone)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                        .focused($fieldFocus, equals: .phone)
                        .submitLabel(.next)
                    
                    TextField("Электронная почта", text: $requestVM.email)
                        .textInputAutocapitalization(.never)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled(true)
                        .focused($fieldFocus, equals: .email)
                        .submitLabel(.done)
                }
                .onSubmit {
                    switchField(currentField: fieldFocus ?? .name)
                }
                
                if requestVM.selectedForm == 0 {
                    
                    // MARK: Скан-копия заявки с подписью
                    
                    Section("Скан-копия заявки с подписью") {
                        ForEach(requestVM.fileUrls1, id: \.self) { url in
                            documentRow(fileUrl: url, from: $requestVM.fileUrls1)
                        }
                        
                        Button {
                            pickerArray = 1
                            resignKeyboard()
                            showFilePicker.toggle()
                        } label: {
                            Text("Добавить файл")
                        }
                    }
                    
                    // MARK: Паспорт
                    
                    Section {
                        ForEach(requestVM.fileUrls2, id: \.self) { url in
                            documentRow(fileUrl: url, from: $requestVM.fileUrls2)
                        }
                        
                        Button {
                            pickerArray = 2
                            resignKeyboard()
                            showFilePicker.toggle()
                        } label: {
                            Text("Добавить файл")
                        }
                    } header: {
                        Text("Копия паспорта")
                    } footer: {
                        Text("Разворот с фото и страница с пропиской")
                    }
                    
                } else {
                    
                    // MARK: Копия документа
                    
                    Section("Копия документа") {
                        ForEach(requestVM.fileUrls3, id: \.self) { url in
                            documentRow(fileUrl: url, from: $requestVM.fileUrls3)
                        }
                        
                        Button {
                            pickerArray = 3
                            resignKeyboard()
                            showFilePicker.toggle()
                        } label: {
                            Text("Добавить файл")
                        }
                    }
                }
                
                // MARK: Примечания
                
                Section {
                    TextField("Примечания", text: $requestVM.comments, axis: .vertical)
                        .keyboardType(.default)
                        .submitLabel(.return)
                        .lineLimit(2...8)
                }
            }
            
            // MARK: Кнопка отправки
            
            LongButton(text: "Отправить заявку", color: .appBlue) {
                resignKeyboard()
                Task {
                    await requestVM.sendRequestViaEmail()
                }
            }
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea(.keyboard)
        .navigationTitle("Отправка заявки")
        .navigationBarTitleDisplayMode(.large)
        //        .toolbar {
        //            ToolbarItemGroup(placement: .keyboard) {
        //                Spacer()
        //
        //                Button(action: resignKeyboard) {
        //                    Text("Готово")
        //                }
        //            }
        //        }
        .fileImporter(isPresented: $showFilePicker, allowedContentTypes: allUTITypes()) { result in
            do {
                let fileUrl = try result.get()
                debugPrint(fileUrl)
                withAnimation {
                    switch pickerArray {
                    case 1:
                        requestVM.fileUrls1.append(fileUrl)
                    case 2:
                        requestVM.fileUrls2.append(fileUrl)
                    case 3:
                        requestVM.fileUrls3.append(fileUrl)
                    default:
                        break
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .fullScreenCover(isPresented: $showPreview) {
            PreviewController(isPresented: self.$showPreview, url: self.$urlForShow)
        }
        .alert("Ошибка", isPresented: $requestVM.isDisplayingError) {
            Button("Закрыть", role: .cancel) { }
        } message: {
            Text(requestVM.lastErrorMessage)
        }
        .overlay {
            if requestVM.showProgressView {
                ZStack {
                    Color.black.opacity(0.3)
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(2)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .onChange(of: requestVM.navigateBackToHomePage) { _ in
            appState.path.removeLast()
            appState.showSentPopup = true
        }
    }
    
    // MARK: Document Row
    func documentRow(fileUrl: URL, from urlArray: Binding<[URL]>) -> some View {
        HStack {
            Button {
                urlForShow = fileUrl
            } label: {
                Text(fileUrl.lastPathComponent)
                    .foregroundColor(.blue)
            }
            Button {
                if let index = urlArray.wrappedValue.firstIndex(of: fileUrl) {
                    withAnimation {
                        urlArray.wrappedValue.remove(at: index)
                    }
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
            }
        }
        .buttonStyle(.borderless)
    }
    
    // MARK: Fields Focus Changing function
    private func switchField(currentField: FocusField) {
        switch currentField {
        case .name:
            fieldFocus = .phone
        case .phone:
            fieldFocus = .email
        case .email:
            fieldFocus = .nothing
        case .nothing:
            break
        }
    }
    
    private func resignKeyboard() {
        if #available(iOS 15, *) {
            fieldFocus = .none
        } else {
            dismissKeyboard()
        }
    }
}

// MARK: - All UTTypes
extension RequestView {
    private func allUTITypes() -> [UTType] {
        let types : [UTType] =
        [.item,
         .content,
         .compositeContent,
         .diskImage,
         .data,
         .directory,
         .resolvable,
         .symbolicLink,
         .executable,
         .mountPoint,
         .aliasFile,
         .urlBookmarkData,
         .url,
         .fileURL,
         .text,
         .plainText,
         .utf8PlainText,
         .utf16ExternalPlainText,
         .utf16PlainText,
         .delimitedText,
         .commaSeparatedText,
         .tabSeparatedText,
         .utf8TabSeparatedText,
         .rtf,
         .html,
         .xml,
         .yaml,
         .sourceCode,
         .assemblyLanguageSource,
         .cSource,
         .objectiveCSource,
         .swiftSource,
         .cPlusPlusSource,
         .objectiveCPlusPlusSource,
         .cHeader,
         .cPlusPlusHeader]
        
        let types_1: [UTType] =
        [.script,
         .appleScript,
         .osaScript,
         .osaScriptBundle,
         .javaScript,
         .shellScript,
         .perlScript,
         .pythonScript,
         .rubyScript,
         .phpScript,
         .makefile, //'makefile' is only available in iOS 15.0 or newer
         .json,
         .propertyList,
         .xmlPropertyList,
         .binaryPropertyList,
         .pdf,
         .rtfd,
         .flatRTFD,
         .webArchive,
         .image,
         .jpeg,
         .tiff,
         .gif,
         .png,
         .icns,
         .bmp,
         .ico,
         .rawImage,
         .svg,
         .livePhoto,
         .heif,
         .heic,
         .webP,
         .threeDContent,
         .usd,
         .usdz,
         .realityFile,
         .sceneKitScene,
         .arReferenceObject,
         .audiovisualContent]
        
        let types_2: [UTType] =
        [.movie,
         .video,
         .audio,
         .quickTimeMovie,
         UTType("com.apple.quicktime-image"),
         .mpeg,
         .mpeg2Video,
         .mpeg2TransportStream,
         .mp3,
         .mpeg4Movie,
         .mpeg4Audio,
         .appleProtectedMPEG4Audio,
         .appleProtectedMPEG4Video,
         .avi,
         .aiff,
         .wav,
         .midi,
         .playlist,
         .m3uPlaylist,
         .folder,
         .volume,
         .package,
         .bundle,
         .pluginBundle,
         .spotlightImporter,
         .quickLookGenerator,
         .xpcService,
         .framework,
         .application,
         .applicationBundle,
         .applicationExtension,
         .unixExecutable,
         .exe,
         .systemPreferencesPane,
         .archive,
         .gzip,
         .bz2,
         .zip,
         .appleArchive,
         .spreadsheet,
         .presentation,
         .database,
         .message,
         .contact,
         .vCard,
         .toDoItem,
         .calendarEvent,
         .emailMessage,
         .internetLocation,
         .internetShortcut,
         .font,
         .bookmark,
         .pkcs12,
         .x509Certificate,
         .epub,
         .log]
            .compactMap({ $0 })
        
        return types + types_1 + types_2
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RequestView()
                .navigationTitle("Отправка заявки")
        }
        .environmentObject(AppState())
    }
}
