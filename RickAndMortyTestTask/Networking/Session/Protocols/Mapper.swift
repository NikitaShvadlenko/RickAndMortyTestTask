//
//  Mapper.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 22.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

protocol Mapper {
    func map<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}
