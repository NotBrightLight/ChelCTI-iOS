//
//  Card.swift
//  ChelCTI_susu
//
//  Created by Артем Васин on 16.07.2022.
//

import SwiftUI

struct Card: Identifiable {
    var id = UUID().uuidString
    let cardColor: Color
    let title: String
    let introduction: String?
    let text: String
}
