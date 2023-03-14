//
//  ButtonsView.swift
//  ChelCTI_susu
//
//  Created by Артем Васин on 12.06.2022.
//

import SwiftUI

struct LongButton: View {
    var text: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(color)
                .frame(height: 56)
                .overlay {
                    Text(text)
                        .foregroundColor(.appWhite)
                        .font(.system(size: 20, weight: .semibold))
                }
        }

    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        LongButton(text: "Отправить заявку", color: .appBlue) {
            //
        }
        .padding(.horizontal, 40)
    }
}
