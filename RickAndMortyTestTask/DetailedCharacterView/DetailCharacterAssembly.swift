//
//  DetailCharacterAssembly.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 20.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import SwiftUI

enum DetailCharacterAssembly {
    static func assemble(characterID: Int) -> some View {
        let networkClient = RickAndMortyAPIClient()
        let viewModel = DetailedCharacterViewModel(networkClient: networkClient)
        let view = DetailedCharacterView(viewModel: viewModel)
        return view
    }
}
