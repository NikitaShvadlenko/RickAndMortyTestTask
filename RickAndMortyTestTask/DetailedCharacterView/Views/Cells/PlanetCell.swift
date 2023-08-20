//
//  PlanetCell.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 20.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import SwiftUI

struct PlanetCell: View {

    let originType: String
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
                    .titleStyle()
                Spacer()
                Text(originType)
                    .bodyStyle()
            }
            .padding([.leading, .top, .bottom], 16)
            Spacer()
        }
        .cellStyle()
    }
}

struct PlanetCell_Previews: PreviewProvider {
    static var previews: some View {
        PlanetCell(originType: "Planet", planetName: "Earth")
    }
}
