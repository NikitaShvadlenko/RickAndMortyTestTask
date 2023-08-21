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
        case failedToDecodeJson
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
        let data = try await fetchDataFromUrl(from: url)
        return data
    }
}

// MARK: - RickAndMortyAPIClientProtocol
extension RickAndMortyAPIClient: RickAndMortyAPIClientProtocol {
    func fetchCharacters(for page: Int) async throws -> CharactersListResponse {
        let url = try setRequestUrl(baseUrlString: baseURL, requestType: .characters)
        let queryItem = URLQueryItem(name: "page", value: "\(page)")
        let data = try await fetchDataFromUrl(from: url, [queryItem])
        guard let characterList = decodeDataFrom(element: CharactersListResponse.self, data: data) else {
            throw RickAndMortyApiError.failedToDecodeJson
        }
        return characterList
    }
}
// MARK: - ManagesDetailCharacterRequests
extension RickAndMortyAPIClient: ManagesDetailCharacterRequests {
    func fetchEpisodes(from urls: [URL]) async throws -> [Episode] {
        var episodes: [Episode] = []
        await withTaskGroup(of: Episode?.self) { [weak self] group in
            guard let self else { return }
            for url in urls {
                group.addTask {
                    do {
                        let data = try await self.fetchDataFromUrl(from: url, nil)
                        guard let episode = self.decodeDataFrom(element: Episode.self, data: data) else {
                            return nil
                        }
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
        let data = try await fetchDataFromUrl(from: url)
        guard let origin = decodeDataFrom(element: Origin.self, data: data) else {
            throw RickAndMortyApiError.failedToDecodeJson
        }
        return origin
    }

    func fetchCharacter(characterId: Int) async throws -> CharacterItem {
        let url = try setRequestUrl(baseUrlString: baseURL, requestType: .character(identificator: characterId))
        let data = try await fetchDataFromUrl(from: url)
        guard let character = decodeDataFrom(element: CharacterItem.self, data: data) else {
            throw RickAndMortyApiError.failedToDecodeJson
        }
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

    private func fetchEpisodes(from url: URL) async throws -> [Episode] {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let result = decodeDataFrom(element: [Episode].self, data: data) else {
            throw RickAndMortyApiError.failedToDecodeJson
        }
        return result
    }

    private func fetchDataFromUrl(from url: URL, _ queryItems: [URLQueryItem]? = nil) async throws -> Data {
        var url = url
        if let queryItems = queryItems {
             url = url.appending(queryItems: queryItems)
        }
        let (data, response) = try await session.data(from: url)
        guard let httpResonse = response as? HTTPURLResponse,
              httpResonse.statusCode == 200 else {
            throw RickAndMortyApiError.invalidResponse
        }
        return data
    }

    private func decodeDataFrom<T: Decodable>(element: T.Type, data: Data) -> T? {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            print(error)
            return nil
        }
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
