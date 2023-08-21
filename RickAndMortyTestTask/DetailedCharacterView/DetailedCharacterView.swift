//
//  DetailedCharacterView.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 20.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import SwiftUI

struct DetailedCharacterView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: DetailedCharacterViewModel

    var body: some View {
        NavigationView {
            List {
                Section {
                    MainInfo(viewModel: viewModel)
                }
                .listRowInsets(EdgeInsets())

                Section(
                    header:
                        Text(L10n.info)
                        .titleStyle()
                        .padding(.bottom, 16)
                ) {
                    InfoCell(infoItems: [
                        InfoCellItem(
                            questionText: L10n.species,
                            answerText: viewModel.generaInformation?.species ?? ""
                        ),
                        InfoCellItem(
                            questionText: L10n.type,
                            answerText: viewModel.generaInformation?.type ?? ""
                        ),
                        InfoCellItem(
                            questionText: L10n.gender,
                            answerText: viewModel.generaInformation?.gender ?? ""
                        )
                    ]
                    )
                }
                .listRowInsets(EdgeInsets())
                .background(Color(asset: Asset.backgroundColor))

                Section(
                    header:
                        Text(L10n.origin)
                        .titleStyle()
                        .padding(.bottom, 16)

                ) {
                    PlanetCell(originType: viewModel.origin?.type ?? "", planetName: viewModel.origin?.name ?? "")
                        .listRowInsets(EdgeInsets())
                        .background(Color(asset: Asset.backgroundColor))
                }
                .listRowInsets(EdgeInsets())
                .background(Color(asset: Asset.backgroundColor))

                Section {
                    ForEach(viewModel.episodes ?? [], id: \.self) { episode in
                        EpisodeCell(episodeName: episode.name, airDate: episode.airDate, episode: episode.episode)
                            .padding(.bottom, 16)
                    }
                    .listRowInsets(EdgeInsets())
                    .background(Color(asset: Asset.backgroundColor))
                }
                header: {
                    Text(L10n.episodes)
                        .titleStyle()
                        .padding(.bottom, 16)
                }
            }
            .overlay {
                if viewModel.isLoading {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .scaleEffect(2.0, anchor: .center)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(asset: Asset.backgroundColor))
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: SFSymbol.backSymbol.rawValue)
                        .foregroundColor(Color(asset: Asset.white))
                }
            }
        }
    }
}

struct MainInfo: View {
    @ObservedObject var viewModel: DetailedCharacterViewModel
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: UIImage(data: viewModel.imageData ?? Data()) ?? UIImage())
                .resizable()
                .frame(width: 148, height: 148)
                .background(Color(asset: Asset.blackCard))
                .cornerRadius(16)
                .padding(.bottom, 24)
            Text(viewModel.generaInformation?.name ?? "")
                .foregroundColor(Color(asset: Asset.white))
                .font(.system(size: 22, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            Text(viewModel.generaInformation?.status ?? "")
                .foregroundColor(Color(asset: Asset.primary))
                .font(.system(size: 16))
        }
        .frame(maxWidth: .infinity)
        .background(Color(asset: Asset.backgroundColor))
    }
}
