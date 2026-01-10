//
//  NetworkClient.swift
//  ExploreCountries
//
//  Created by Heba on 10/01/2026.
//

import Foundation

protocol NetworkClient {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
