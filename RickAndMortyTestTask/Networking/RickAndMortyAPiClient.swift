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
    enum RickAndMortyApiError: Error {
        case failedToCreateURL
        case invalidResponse
    }

    private let session: URLSession
    private let sessionConfiguration: URLSessionConfiguration
    private var baseURL = "https://rickandmortyapi.com"

    init() {
        self.sessionConfiguration = URLSessionConfiguration.default
        self.session = URLSession(configuration: sessionConfiguration)
    }
}

// MARK: - ImageDownloaderProtocol
extension RickAndMortyAPIClient: ImageDownloaderProtocol {
    func fetchImage(from url: URL) async throws -> Data {
        let (data, response) = try await session.data(from: url)
        guard let httpResonse = response as? HTTPURLResponse,
              httpResonse.statusCode == 200 else {
            throw RickAndMortyApiError.invalidResponse
        }
        return data
    }
}

// MARK: - RickAndMortyAPIClientProtocol
extension RickAndMortyAPIClient: RickAndMortyAPIClientProtocol {
    func fetchCharacters(for page: Int) async throws -> CharactersListResponse {
        var url = try setRequestUrl(baseUrlString: baseURL, requestType: .characters)
        let queryItem = URLQueryItem(name: "page", value: "\(page)")
        url.append(queryItems: [queryItem])
        let (data, response) = try await session.data(from: url)
        guard let httpResonse = response as? HTTPURLResponse,
              httpResonse.statusCode == 200 else {
            throw RickAndMortyApiError.invalidResponse
        }
         let characterList = try JSONDecoder().decode(CharactersListResponse.self, from: data)
        return characterList
    }
}
// MARK: - ManagesDetailCharacterRequests
extension RickAndMortyAPIClient: ManagesDetailCharacterRequests {
    func fetchEpisodes(from urls: [URL]) async throws -> [Episode] {
        var episodes: [Episode] = []
        await withTaskGroup(of: Episode?.self) { group in
            for url in urls {
                group.addTask {
                    do {
                        let (data, response) = try await self.session.data(from: url)
                        guard let httpResonse = response as? HTTPURLResponse,
                              httpResonse.statusCode == 200 else {
                            print("invalid response")
                            return nil
                        }
                        let episode = try JSONDecoder().decode(Episode.self, from: data)
                        return episode
                    } catch {
                        print("Error fetching or parsing episode from \(url): \(error)")
                        return nil
                    }
                }
            }

            for await episode in group {
                if let episode = episode {
                    episodes.append(episode)
                }
            }
        }
        return episodes
    }

    func fetchOrigin(from url: URL) async throws  -> Origin {
        let (data, response) = try await session.data(from: url)
        guard let httpResonse = response as? HTTPURLResponse,
              httpResonse.statusCode == 200 else {
            throw RickAndMortyApiError.invalidResponse
        }
        let origin = try JSONDecoder().decode(Origin.self, from: data)
        return origin
    }

    func fetchCharacter(characterId: Int) async throws -> CharacterItem {
        var url = try setRequestUrl(baseUrlString: baseURL, requestType: .character(identificator: characterId))
        let (data, response) = try await session.data(from: url)
        guard let httpResonse = response as? HTTPURLResponse,
              httpResonse.statusCode == 200 else {
            throw RickAndMortyApiError.invalidResponse
        }
        let character = try JSONDecoder().decode(CharacterItem.self, from: data)
        return character
    }
}

// MARK: - Private methods
extension RickAndMortyAPIClient {
    private func setRequestUrl(baseUrlString: String, requestType: RickAndMortyApiRequestType) throws -> URL {
        guard var url = URL(string: baseUrlString) else {
            throw RickAndMortyApiError.failedToCreateURL
        }
        url.append(path: requestType.path)
        return url
    }

    func fetchEpisodes(from url: URL) async throws -> [Episode] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode([Episode].self, from: data)
    }
}

extension RickAndMortyAPIClient {
    private enum RickAndMortyApiRequestType {
        case locations
        case characters
        case episodes
        case character(identificator: Int)

        var path: String {
            switch self {
            case .locations:
                return "api/location"
            case .characters:
                return "api/character"
            case .episodes:
                return "api/episode"
            case .character(let identificator):
                return "api/character/\(identificator)"
            }
        }
    }

}
