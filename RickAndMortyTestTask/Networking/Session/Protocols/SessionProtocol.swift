//
//  SessionProtocol.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 23.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

protocol SessionProtocol {
    func makeDataRequest<T: Decodable>(_ request: Request) async throws -> T
    func makeBatchDataRequest<T: Decodable>(requests: [Request]) async throws -> [T]
}
