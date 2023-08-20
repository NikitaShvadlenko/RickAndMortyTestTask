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
                FormView(infoItem: item)
            }
        }
        .padding(16)
        .cellStyle()
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

struct FormView: View {
    var infoItem: InfoCellItem

    var body: some View {
        HStack {
            Text(infoItem.questionText)
                .font(.system(size: 16))
                .foregroundColor(Color(asset: Asset.grayNormal))
            Spacer()
            Text(infoItem.answerText)
                .font(.system(size: 16))
                .foregroundColor(Color(asset: Asset.white))
        }
    }
}
