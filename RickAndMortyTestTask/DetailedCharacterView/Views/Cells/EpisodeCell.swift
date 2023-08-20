//
//  EpisodeCell.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 20.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import SwiftUI

struct EpisodeCell: View {
    let episodeName: String
    let airDate: String
    let episode: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                Text(episodeName)
                    .titleStyle()
                    .padding(.top, 16)
                Text(episode)
                    .bodyStyle()
            }
            .padding(.leading, 15.25)
            Spacer()
            VStack {
                Spacer()
                Text(airDate)
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(Color(asset: Asset.secondaryText))
            }
            .padding(.trailing, 15.68)
        }
        .padding(.bottom, 14)
        .cellStyle()
    }
}

struct EpisodeCell_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeCell(
            episodeName: "Pilot",
            airDate: "December 2, 2013",
            episode: "Episode 3, Season 1"
        )
    }
}
