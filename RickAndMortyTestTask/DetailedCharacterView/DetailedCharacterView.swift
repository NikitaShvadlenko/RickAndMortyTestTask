//
//  DetailedCharacterView.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 20.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import SwiftUI

struct DetailedCharacterView: View {
    // TODO: Instead of using list, use ordinary scrollView

    let viewModel: ManagesDetailCharacterView

    var body: some View {
        List {
            Section {
                MainInfo()
            }
            .listRowInsets(EdgeInsets())
            Section(
                header:
                    Text("Info")
                    .titleStyle()
                    .padding(.bottom, 16)
            ) {
                InfoCell(infoItems: [
                    InfoCellItem(questionText: "cdwdfwe", answerText: "dwedfwe"),
                    InfoCellItem(questionText: "cdwdfwe", answerText: "dwedfwe"),
                    InfoCellItem(questionText: "cdwdfwe", answerText: "dwedfwe")
                ])
                .listRowInsets(EdgeInsets())
                .background(Color.clear)

            }

            Section(
                header:
                    Text("Origin")
                    .titleStyle()
                    .padding(.bottom, 16)

            ) {
                PlanetCell(planetName: "Earth")
                    .listRowInsets(EdgeInsets())
                    .background(Color.clear)
            }

            Section {
                EpisodeCell(episodeName: "dwed", airDate: "12332", episode: "dwfew")
            } header: {
                Text("Episodes")
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color(asset: Asset.backgroundColor))
    }
}

//struct DetailedCharacterView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedCharacterView(viewModel: DetailedCharacterView(viewModel: DetailedCharacterViewModel()) )
//    }
//}

struct MainInfo: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 148, height: 148)
                .background(Color.red)
                .cornerRadius(16)
                .padding(.bottom, 24)
            Text("Rick Sanchez")
                .foregroundColor(Color(asset: Asset.white))
                .font(.system(size: 22, weight: .semibold))
                .padding(.bottom, 8)
            Text("Alive")
                .foregroundColor(Color(asset: Asset.primary))
                .font(.system(size: 16))
        }
        .frame(maxWidth: .infinity)
        .background(Color(asset: Asset.backgroundColor))
    }
}
