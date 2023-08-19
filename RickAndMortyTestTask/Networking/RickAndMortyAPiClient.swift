//
//  RickAndMortyAPiClient.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 19.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

protocol RickAndMortyAPIClientProtocol {
    func fetchCharacters(for page: Int) async throws -> CharactersListResponse
}

final class RickAndMortyAPIClient {
    enum RickAndMortyApiError: Error {
        case failedToCreateURL
        case invalidResponse
    }

    private let session: URLSession
    private let sessionConfiguration: URLSessionConfiguration
    private var baseURL = "https://rickandmortyapi.com/api"

    init() {
        self.sessionConfiguration = URLSessionConfiguration.default
        self.session = URLSession(configuration: sessionConfiguration)
    }
}

// MARK: - RickAndMortyAPIClientProtocol
extension RickAndMortyAPIClient: RickAndMortyAPIClientProtocol {
    func fetchCharacters(for page: Int) async throws -> CharactersListResponse {
        let url = try setRequestUrl(baseUrlString: baseURL, requestType: .characters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["page": "\(page)"]
        let (data, response) = try await session.data(for: request)
        guard let httpResonse = response as? HTTPURLResponse,
              httpResonse.statusCode == 200 else {
            throw RickAndMortyApiError.invalidResponse
        }
         let characterList = try JSONDecoder().decode(CharactersListResponse.self, from: data)
        return characterList
    }
}

// MARK: - Private methods
extension RickAndMortyAPIClient {
    private func setRequestUrl(baseUrlString: String, requestType: RickAndMortyApiRequestType) throws -> URL {
        guard var url = URL(string: baseUrlString) else {
            throw RickAndMortyApiError.failedToCreateURL
        }
        url.append(path: requestType.rawValue)
        return url
    }
}

extension RickAndMortyAPIClient {
    private enum RickAndMortyApiRequestType: String {
        // we only need characters in this test
        case locations = "location"
        case characters = "character"
        case episodes = "episode"
    }
}
