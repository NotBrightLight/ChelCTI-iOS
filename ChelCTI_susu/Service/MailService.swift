//
//  SendMail.swift
//  ChelCTI_susu
//
//  Created by Артем Васин on 16.06.2022.
//

import Foundation

class MailService {
    
    static let shared = MailService()
    private init() {}
    
    func sendEmailAsync(to mail: String, title: String, text: String, files: [URL]) async throws {
        
        let dataWithMIME: [(name: String, data: String, mime: String)] = files.compactMap { url in
            do {
                let name = url.lastPathComponent
                let mime = url.mimeType()
                let data = try Data(contentsOf: url)
                let convertedData = data.base64EncodedString()
                return (name, convertedData, mime)
            } catch {
                return nil
            }
        }
        
        let attachments = dataWithMIME.map { file in
            [
                "content": file.data,
                "filename": file.name,
                "type": file.mime,
                "disposition": "attachment"
            ]
        }
        
        let headers = [
            "content-type": "application/json",
            "X-RapidAPI-Key": getRapidAPIFromInfoPlist("RAPID_API_KEY"),
            "X-RapidAPI-Host": "rapidprod-sendgrid-v1.p.rapidapi.com"
        ]
        
        let parameters: [String : Any] = [
            "personalizations": [
                [
                    "to": [["email": mail]],
                    "subject": title
                ]
            ],
            "from": ["email": "test@example.com"],
            "content": [
                    [
                        "type": "text/plain",
                        "value": text
                    ]
                ],
            "attachments": attachments
        ]
        
        let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        
        guard let url = URL(string: "https://rapidprod-sendgrid-v1.p.rapidapi.com/mail/send") else { throw "The URL could not be created."}
        
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let (_, response) = try await URLSession.shared.upload(for: request, from: postData)

        guard (response as? HTTPURLResponse)?.statusCode == 202 || (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "The server responded with an error."
        }
    }
    
    private func getRapidAPIFromInfoPlist(_ keyName: String) -> String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: keyName) as? String else { return "" }
        return key
    }
}
