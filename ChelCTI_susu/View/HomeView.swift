//
//  HomeView.swift
//  ChelCTI_susu
//
//  Created by Артем Васин on 13.06.2022.
//

import SwiftUI
import PopupView

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var showSafari: Bool = false
    
    // Detail Hero Page..
    @State var showDetailPage: Bool = false
    @State var currentCard: Card?
    
    // For Hero Animation
    // Using Namespace...
    @Namespace var animation
    // showing Detail content a bit later...
    @State var showDetailContent: Bool = false
    
    var body: some View {
        NavigationStack(path: $appState.path) {
            VStack(alignment: .leading) {
                Text("ОГУП \"Обл. ЦТИ\"")
                    .font(.largeTitle.bold())
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Group {
                    Text("Наши услуги:")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                    
                    GeometryReader { proxy in
                        
                        let size = proxy.size
                        
                        let trailingCardsToShown: CGFloat = 2
                        let trailingSpaceofEachCards: CGFloat = 20
                        
                        ZStack{
                            ForEach(appState.cards) { card in
                                InfiniteStackedCardView(cards: $appState.cards,
                                                        card: card,
                                                        trailingCardsToShown: trailingCardsToShown,
                                                        trailingSpaceofEachCards: trailingSpaceofEachCards,
                                                        animation: animation,
                                                        showDetailPage: $showDetailPage)
                                // Setting On tap...
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        currentCard = card
                                        showDetailPage = true
                                    }
                                }
                            }
                        }
                        .padding(.trailing, (trailingCardsToShown * trailingSpaceofEachCards))
                        .frame(height: size.height)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                    
                    VStack {
                        LongButton(text: "Отправить заявку", color: .appBlue) {
                            //appState.path.append(.sendRequest)
                            appState.path.append(.sendRequest)
                        }
                        
                        LongButton(text: "Пункты приема", color: .card) {
                            appState.path.append(.map)
                        }
                    }
                    .padding(.vertical, 10)
                    
                    HStack {
                        Link("Телефон", destination: URL(string: "tel:83512323205")!)
                            .frame(maxWidth: .infinity)

                        Button("Сайт") {
                            showSafari.toggle()
                        }
                        .frame(maxWidth: .infinity)
                        
                        Link("Почта", destination: URL(string: "mailto:oblcti@chel.surnet.ru")!)
                            .frame(maxWidth: .infinity)
                    }
                    
                }
                .padding(.horizontal, 20)
            }
            .navigationDestination(for: AppNavigationType.self) { value in
                switch value {
                case .sendRequest: RequestView()
                case .map: MapView()
                case .address(let place): AddressView(place: place)
                }
            }
            .navigationTitle("Главная")
            .toolbar(.hidden)
        }
        .fullScreenCover(isPresented: $showSafari) {
            WebView(url: URL(string: "https://chelcti.ru/")!)
        }
        .popup(isPresented: $appState.showSentPopup, type: .toast, position: .bottom, autohideIn: 10, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: true) {
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.green)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Заявка успешно отправлена!")
                        .font(.system(size: 16, weight: .bold))
                    Text("Заявка будет обработана в возможно короткие сроки. Ответ придет на Вашу почту.")
                        .font(.system(size: 16, weight: .light))
                        .opacity(0.8)
                }
                
                Spacer()
            }
            .foregroundColor(.black)
            .padding(EdgeInsets(top: 24, leading: 16, bottom: 42, trailing: 16))
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .shadow(color: .black.opacity(0.1), radius: 40, x: 0, y: -4)
        }
        .overlay(
            DetailPage()
        )
    }
    
    @ViewBuilder
    func DetailPage() -> some View {
        ZStack{
            
            if let currentCard = currentCard,showDetailPage {
                
                Rectangle()
                    .fill(currentCard.cardColor)
                    .matchedGeometryEffect(id: currentCard.id, in: animation)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    // Close Button...
                    Button {
                        withAnimation{
                            // Closing View..
                            showDetailContent = false
                            showDetailPage = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white.opacity(0.6))
                            .clipShape(Circle())
                    }
                    // Moving view to left Without Any Spacers..
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    Text(currentCard.title)
                        .font(.title.bold())
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        // Sample Content...
                        Text(currentCard.text)
                            .kerning(1.1)
                            .lineSpacing(6)
                            .multilineTextAlignment(.leading)
                            .padding(.top,10)
                    }
                }
                .opacity(showDetailContent ? 1 : 0)
                .foregroundColor(.white)
                .padding()
                // Moving view to top Without Any Spacers..
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        
                        withAnimation{
                            showDetailContent = true
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppState())
    }
}

struct InfiniteStackedCardView: View {
    
    @Binding var cards: [Card]
    var card: Card
    var trailingCardsToShown: CGFloat
    var trailingSpaceofEachCards: CGFloat
    
    // For Hero Animation...
    var animation: Namespace.ID
    @Binding var showDetailPage: Bool
    
    // Gesture Properties...
    // Used to tell whether user is Dragging Cards...
    @GestureState var isDragging: Bool = false
    // Used to store Offset..
    @State var offset: CGFloat = .zero
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 15) {
            
            Text(card.title)
                .font(.title.bold())
                .padding(.top)
            
            if card.introduction != nil {
                Text(card.introduction!)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .kerning(0.4)
            }
            
            Spacer()
            
            // Since I need icon at right
            // Simply swap the content inside label...
            Label {
                Image(systemName: "arrow.right")
            } icon: {
                Text("Подробнее")
            }
            .font(.system(size: 15, weight: .semibold))
            // Moving To right without Spacers...
            .frame(maxWidth: .infinity,alignment: .trailing)
            
        }
        .padding()
        .padding(.vertical,10)
        .foregroundColor(.white)
        // Giving Background Color
        .background(
            
            ZStack{
                // Ignore Warnings...
                // if you want smooth animation...
                
                // Matched Geometry effect not animating smoothly when we hide the original content...
                // don't avoid original content if you want smooth animation...
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(card.cardColor)
                    .matchedGeometryEffect(id: card.id, in: animation)
            }
        )
        .padding(.trailing,-getPadding())
        // Applying vertical padding...
        // to look like shrinking...
        .padding(.vertical,getPadding())
        // since we use ZStack all cards are reversed...
        // Simply undoing with the help of ZIndex..
        .zIndex(Double(CGFloat(cards.count) - getIndex()))
        .rotationEffect(.init(degrees: getRotation(angle: 10)))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .offset(x: offset)
        .gesture(
            
            DragGesture()
                .updating($isDragging, body: { _, out, _ in
                    out = true
                })
                .onChanged({ value in
                    
                    var translation = value.translation.width
                    // Applying Translation for only First card to avoid dragging bottom Cards...
                    translation = cards.first?.id == card.id ? translation : 0
                    // Applying dragging only if its dragged..
                    translation = isDragging ? translation : 0
                    
                    // Stopping Right Swipe...
                    translation = (translation < 0 ? translation : 0)
                    
                    offset = translation
                })
                .onEnded({ value in
                    
                    // Checking if card is swiped more than width...
                    let width = UIScreen.main.bounds.width
                    let cardPassed = -offset > (width / 2)
                    
                    withAnimation(.easeInOut(duration: 0.2)){
                        
                        if cardPassed{
                            offset = -width
                            removeAndPutBack()
                        }
                        else{
                            
                            offset = .zero
                        }
                    }
                })
        )
    }
    
    // removing Card from first and putting it back at last so it look like infinite staked carousel without using Memory...
    func removeAndPutBack(){
        
        // Removing card after animation finished...
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            // Updating card id
            // to avoid Foreach Warning...
            var updatedCard = card
            updatedCard.id = UUID().uuidString
            
            cards.append(updatedCard)
            
            withAnimation {
                // removing first card...
                cards.removeFirst()
            }
        }
    }
    
    // Rotating Card while Dragging...
    func getRotation(angle: Double)->Double{
        // Removing Paddings...
        let width = UIScreen.main.bounds.width - 50
        let progress = offset / width
        
        return Double(progress) * angle
    }
    
    func getPadding()->CGFloat{
        
        // retrieving padding for each card(At trailing...)
        
        let maxPadding = trailingCardsToShown * trailingSpaceofEachCards
        
        let cardPadding = getIndex() * trailingSpaceofEachCards
        
        // retuning only number of cards declared...
        return (getIndex() <= trailingCardsToShown ? cardPadding : maxPadding)
    }
    
    // Retrieving Index to find which card need to show...
    func getIndex()->CGFloat{
        
        let index = cards.firstIndex { card in
            return self.card.id == card.id
        } ?? 0
        
        return CGFloat(index)
    }
}
