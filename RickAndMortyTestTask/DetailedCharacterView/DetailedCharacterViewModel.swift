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
    var characterId: Int
    var networkClient: ManagesDetailCharacterRequests
    var generaInformation: CharacterItem? {
        didSet {

        }
    }

    init(networkClient: ManagesDetailCharacterRequests, characterId: Int) {
        self.networkClient = networkClient
        self.characterId = characterId
    }
}

// MARK: - Private Methods
extension DetailedCharacterViewModel {
    private func setGeneralInformation() {
        Task {
            do {
                let result = try await networkClient.fetchCharacter(characterId: characterId)
                Task { @MainActor in
                    self.generaInformation = result
                }
            } catch {
                print(error)
            }
        }
    }

    private func fetchOrigin() {
        Task {
            do {
                let result = try await networkClient.fetchCharacter(characterId: characterId)
                Task { @MainActor in
                    self.generaInformation = result
                }
            } catch {
                print(error)
            }
        }
    }
}
