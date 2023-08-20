//
//  DetailedCharacterViewModel.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 20.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

protocol ManagesDetailCharacterView {
    var generaInformation: CharacterItem? { get }
}

final class DetailedCharacterViewModel: ManagesDetailCharacterView {
    var networkClient: ManagesDetailCharacterRequests
    var generaInformation: CharacterItem?

    init(networkClient: ManagesDetailCharacterRequests) {
        self.networkClient = networkClient
    }
}
