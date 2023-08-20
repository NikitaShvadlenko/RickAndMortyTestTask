//
//  Episode.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 20.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

struct Episode: Codable, Hashable {
    let name: String
    let airDate: String
    let episode: String
    let identificator: Int

    enum CodingKeys: String, CodingKey {
        case name
        case airDate = "air_date"
        case episode
        case identificator = "id"
    }
}
