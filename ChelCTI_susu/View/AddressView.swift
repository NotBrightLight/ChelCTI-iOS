//
//  AddressView.swift
//  ChelCTI_susu
//
//  Created by Артем Васин on 18.07.2022.
//

import SwiftUI
import MapKit

struct AddressView: View {
    @EnvironmentObject var appState: AppState
    
    let place: Place
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                Text(place.name)
                    .font(.largeTitle.bold())
                
                Label(place.address, systemImage: "house.fill")
                
                if let manager = place.manager {
                    Text(manager)
                }
                
                if let phones = place.phoneNumbers {
                    ForEach(phones, id: \.self) { phone in
                        Label(phone, systemImage: "phone.fill")
                    }
                }
                
                let lines = place.graphic.split(whereSeparator: \.isNewline)
                ForEach(lines, id: \.self) { line in
                    Label(line, systemImage: "clock.fill")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .foregroundColor(.white)
            .background {
                RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                    .fill(Color.appBlue)
            }
            .padding(.top, 50)
            .padding(.horizontal, 10)
            
            Spacer()
                .frame(height: 30)
            
            Button("На главную") {
                appState.path.removeAll()
            }
            .buttonStyle(.bordered)
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(place: Place.places.first!)
            .environmentObject(AppState())
    }
}
