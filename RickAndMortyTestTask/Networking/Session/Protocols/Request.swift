//
//  Request.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 22.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import Foundation

protocol Request {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var mapper: Mapper { get }
}
