//
//  RickAndMortyAPiClient.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 19.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

protocol ImageDownloaderProtocol {
    func fetchImage(from url: URL) async throws -> Data
}

protocol RickAndMortyAPIClientProtocol {
    func fetchCharacters(for page: Int) async throws -> CharactersListResponse
}

protocol ManagesDetailCharacterRequests {
    func fetchEpisodes(from urls: [URL]) async throws -> [Episode]
    func fetchOrigin(from url: URL) async throws  -> Origin
    func fetchCharacter(characterId: Int) async throws -> CharacterItem
}

final class RickAndMortyAPIClient {
    let session: SessionProtocol
    init(session: SessionProtocol) {
        self.session = session
    }
}

// MARK: - ImageDownloaderProtocol
extension RickAndMortyAPIClient: ImageDownloaderProtocol {
    func fetchImage(from url: URL) async throws -> Data {
        try await session.makeDataRequest(RickAndMortyRequest.imageDataFromURL(url: url))
    }
}

// MARK: - RickAndMortyAPIClientProtocol
extension RickAndMortyAPIClient: RickAndMortyAPIClientProtocol {
    func fetchCharacters(for page: Int) async throws -> CharactersListResponse {
        try await session.makeDataRequest(RickAndMortyRequest.characters(page: page))
    }
}
// MARK: - ManagesDetailCharacterRequests
extension RickAndMortyAPIClient: ManagesDetailCharacterRequests {
    func fetchEpisodes(from urls: [URL]) async throws -> [Episode] {
        var requests: [RickAndMortyRequest] = []
        for url in urls {
            let request = RickAndMortyRequest.dataRequestFromUrl(url: url)
            requests.append(request)
        }
        return try await session.makeBatchDataRequest(requests: requests)
    }

    func fetchOrigin(from url: URL) async throws  -> Origin {
        return try await session.makeDataRequest(RickAndMortyRequest.dataRequestFromUrl(url: url))
    }

    func fetchCharacter(characterId: Int) async throws -> CharacterItem {
        try await session.makeDataRequest(RickAndMortyRequest.character(identificator: characterId))
    }
}
