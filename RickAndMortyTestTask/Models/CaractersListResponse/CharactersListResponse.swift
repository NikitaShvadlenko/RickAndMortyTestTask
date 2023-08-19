//
//  CharactersListResponse.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 19.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

struct CharactersListResponse: Codable {
    let info: Info
    let results: [CharacterListItem]
}
