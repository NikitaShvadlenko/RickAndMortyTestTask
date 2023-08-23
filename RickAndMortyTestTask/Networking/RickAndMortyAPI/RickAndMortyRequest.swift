//
//  CharacterItemRequest.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 23.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

enum RickAndMortyRequest {
    case locations
    case characters(page: Int)
    case episodes
    case character(identificator: Int)
    case dataRequestFromUrl(url: URL)
    case imageDataFromURL(url: URL)
}

extension RickAndMortyRequest: Request {
    var baseUrl: URL {
        switch self {
        case .dataRequestFromUrl(let url):
            return url
        case .imageDataFromURL(let url):
            return url
        default:
            return URL(string: "https://rickandmortyapi.com")!
        }
    }

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
        case .dataRequestFromUrl, .imageDataFromURL:
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

    var mapper: Mapper {
        switch self {
        case .imageDataFromURL:
           return DataMapper()
        default:
            return JSONMapper()
        }
    }

}
