//
//  DataMapper.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 23.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

struct DataMapper: Mapper {
    enum DataMapperError: Error {
        case incorrectDataType
    }

    func map<T>(_ type: T.Type, from data: Data) throws -> T {
        guard let data = data as? T else {
            throw DataMapperError.incorrectDataType
        }
        return data
    }
}
