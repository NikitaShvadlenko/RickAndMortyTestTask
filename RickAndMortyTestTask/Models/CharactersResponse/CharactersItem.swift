//
//  CharactersItem.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 19.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

struct CharacterItem: Codable {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterItemOrigin
    let image: URL
    let episode: [URL]
}

struct CharacterItemOrigin: Codable {
    let name: String
    let url: URL?
}
