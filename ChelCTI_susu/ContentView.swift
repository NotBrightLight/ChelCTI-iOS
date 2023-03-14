//
//  ContentView.swift
//  ChelCTI_susu
//
//  Created by Артем Васин on 12.06.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
    }
}
