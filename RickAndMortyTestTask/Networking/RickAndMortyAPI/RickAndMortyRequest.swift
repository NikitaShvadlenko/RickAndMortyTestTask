//
//  CharacterItemRequest.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 23.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

enum RickAndMortyRequest {
    case characters(page: Int)
    case episodes
    case character(identificator: Int)
    case origin(url: URL)
    case episode(url: URL)
    case image(url: URL)
}

extension RickAndMortyRequest: Request {
    var baseUrl: URL {
        switch self {
        case .origin(let url):
            return url
        case .image(let url):
            return url
        case .episode(let url):
            return url
        default:
            return URL(string: "https://rickandmortyapi.com")!
        }
    }

    var path: String {
        switch self {
        case .characters:
            return "api/character"
        case .episodes:
            return "api/episode"
        case .character(let identificator):
            return "api/character/\(identificator)"
        case .origin, .episode, .image:
            return ""
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .characters(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
        default:
            return nil
        }
    }

    var mapper: any Mapper {
        switch self {
        case .characters:
            return JSONMapper<CharactersListResponse>()
        case .episode:
            return JSONMapper<Episode>()
        case .character:
            return JSONMapper<CharacterItem>()
        case .image:
            return DataMapper()
        case .episodes:
            return JSONMapper<Episode>()
        case .origin:
            return JSONMapper<Origin>()
        }
    }

}
