//
//  InfoCell.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 20.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import SwiftUI

struct InfoCell: View {
    let infoItems: [InfoCellItem]

    var body: some View {
        VStack(spacing: 16) {
            ForEach(infoItems, id: \.questionText) { item in
                ExtractedView(infoItem: item)
            }
        }
        .padding(16)
        .background(Color(asset: Asset.blackCard))
        .cornerRadius(16)
        .padding()
    }
}

struct InfoCell_Previews: PreviewProvider {
    static var previews: some View {
        InfoCell(infoItems: [
            InfoCellItem(questionText: L10n.species, answerText: "Human"),
            InfoCellItem(questionText: L10n.type, answerText: "None"),
            InfoCellItem(questionText: L10n.gender, answerText: "Male")
        ])
    }
}

// MARK: - Extensions
struct GeneralField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16))
            .foregroundColor(Color(asset: Asset.grayNormal))
    }
}

struct GeneralFieldAnswer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16))
            .foregroundColor(Color(asset: Asset.white))
    }
}

extension View {
    func generalFieldStyle() -> some View {
        modifier(GeneralField())
    }

    func generalFieldAnswerStyle() -> some View {
        modifier(GeneralFieldAnswer())
    }
}

struct ExtractedView: View {
    var infoItem: InfoCellItem

    var body: some View {
        HStack {
            Text(infoItem.questionText)
                .generalFieldStyle()
            Spacer()
            Text(infoItem.answerText)
                .generalFieldAnswerStyle()
        }
    }
}
