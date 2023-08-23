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
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try? container.decodeIfPresent(URL.self, forKey: .url)
    }

    let name: String
    let url: URL?
}
