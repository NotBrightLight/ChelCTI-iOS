//
//  ChelCTI_susuApp.swift
//  ChelCTI_susu
//
//  Created by Артем Васин on 12.06.2022.
//

import SwiftUI

@main
struct ChelCTI_susuApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppState())
        }
    }
}
