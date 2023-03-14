//
//  RequestVM.swift
//  ChelCTI_susu
//
//  Created by Артем Васин on 13.06.2022.
//

import SwiftUI

class RequestVM: ObservableObject {
    @Published var selectedForm = 0
    
    let pickerOptions: [String] = [
        "Получение сведений из учетно-технической документации",
        "Проведение кадастровых работ"
    ]
    
    @Published var name = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var comments = ""
    
    @Published var fileUrls1: [URL] = []
    @Published var fileUrls2: [URL] = []
    
    @Published var fileUrls3: [URL] = []
    
    /// Description of the latest error to display to the user.
    @Published var lastErrorMessage = "" {
        didSet {
            isDisplayingError = true
        }
    }
    @Published var isDisplayingError = false
    
    /// Show loading circle while sending Email
    @Published var showProgressView = false
    
    /// After Email was sent
    @Published var navigateBackToHomePage = false
    
    /// Computed property to check that all required fields are filled.
    var isValid: Bool {
        guard !name.isEmpty else {
            lastErrorMessage = "Укажите ФИО."
            return false
        }
        guard !phone.isEmpty else {
            lastErrorMessage = "Укажите номер телефона."
            return false
        }
        guard !email.isEmpty else {
            lastErrorMessage = "Укажите электронную почту."
            return false
        }
        
        if selectedForm == 0 {
            guard !fileUrls1.isEmpty else {
                lastErrorMessage = "Прикрепите скан-копию заявки с подписью."
                return false
            }
            guard !fileUrls2.isEmpty else {
                lastErrorMessage = "Прикрепите копию паспорта."
                return false
            }
        } else {
            guard !fileUrls3.isEmpty else {
                lastErrorMessage = "Прикрепите копию документа."
                return false
            }
        }
        
        return true
    }
    
    @MainActor
    func sendRequestViaEmail() async {
        guard isValid else {
            return
        }
        
        showProgressView = true
        
        let text = """
        ФИО: \(name)
        Телефон: \(phone)
        Электронная почта: \(email)
        Комментарии к заявке:
        ---
        \(comments.isEmpty ? "Нет комментариев." : comments)
        ---
        Файлы во вложениях.
        """
        
        do {
            try await MailService.shared.sendEmailAsync(
                to: "test@example.com",
                title: "Новая заявка на \(pickerOptions[selectedForm])",
                text: text,
                files: selectedForm == 0 ? fileUrls1 + fileUrls2 : fileUrls3)
        } catch {
            lastErrorMessage = error.localizedDescription
        }
        
        actionsAfterEmailSent()
    }
    
    private func actionsAfterEmailSent() {
        name = ""
        phone = ""
        email = ""
        comments = ""
        fileUrls1 = []
        fileUrls2 = []
        fileUrls3 = []
        showProgressView = false
        navigateBackToHomePage.toggle()
    }
}
