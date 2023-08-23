//
//  Mapper.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 22.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

protocol Mapper {
    associatedtype MappedType
    func map(from data: Data) throws -> MappedType
}
