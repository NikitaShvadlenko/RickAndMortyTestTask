//
//  MovieCharacterListItem.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 19.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import UIKit

struct CharacterListItem: Codable, Hashable {
    let identifier = UUID()
    let name: String
    let image: URL
    // swiftlint:disable identifier_name
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name
        case image
        case id
    }
}
