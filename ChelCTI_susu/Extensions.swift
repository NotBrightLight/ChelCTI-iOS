//
//  Extensions.swift
//  ChelCTI_susu
//
//  Created by Артем Васин on 12.06.2022.
//

import SwiftUI
import UniformTypeIdentifiers
import MapKit

// MARK: Colors

extension Color {
    static let appBlue = Color("Blue")
    static let appWhite = Color("White")
    
    static let card = Color("Card")
}

// MARK: View

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

extension View {
    // For iOS 14 and lower
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: URL

extension URL {
    /// Get MIME type of file from URL
    public func mimeType() -> String {
        if let mimeType = UTType(filenameExtension: self.pathExtension)?.preferredMIMEType {
            return mimeType
        }
        else {
            return "application/octet-stream"
        }
    }
}

// MARK: - CLLocationCoordinate2D

extension CLLocationCoordinate2D: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
}

// MARK: - String

/// Easily throw generic errors with a text description.
extension String: Error { }
