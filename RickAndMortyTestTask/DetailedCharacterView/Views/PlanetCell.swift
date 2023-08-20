//
//  PlanetCell.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 20.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import SwiftUI

struct PlanetCell: View {

    let planetName: String

    var body: some View {
        HStack() {
            Image(asset: Asset.planet)
                .resizable()
                .scaledToFit()
                .padding(20)
                .foregroundColor(Color.red)
                .frame(width: 64, height: 64)
                .background(Color(asset: Asset.blackElement))
                .cornerRadius(10)
                .padding([.leading, .top, .bottom], 8)

            VStack(alignment: .leading) {
                Text(planetName)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(Color(asset: Asset.white))
                Spacer()
                Text(L10n.planet)
                    .font(.system(size: 13))
                    .foregroundColor(Color(asset: Asset.primary))
            }
            .padding([.leading, .top, .bottom], 16)
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
        .background(Color(asset: Asset.blackCard))
        .cornerRadius(16)
        .padding()
    }
}

struct PlanetCell_Previews: PreviewProvider {
    static var previews: some View {
        PlanetCell(planetName: "Earth")
    }
}
