//
//  JSONMapper.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 22.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

struct JSONMapper<T: Decodable>: Mapper {
    func map(from data: Data) throws -> T {
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
}
