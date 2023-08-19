//
//  CharactersResponse.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 19.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

struct CharactersResponse: Codable {
    let info: Info
    let results: [CharacterItem]
}

struct Info: Codable {
    let pages: Int
    let count: Int
    let next: String
}

struct CharacterItem: Codable {
    // swiftlint:disable identifier_name
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOrigin
    let location: CharacterLocation
    let image: String
}

struct CharacterOrigin: Codable {
    let name: String
    // we don't need a location url for this task
}

struct CharacterLocation: Codable {
    let name: String
}
