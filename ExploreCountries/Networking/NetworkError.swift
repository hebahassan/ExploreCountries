//
//  NetworkError.swift
//  ExploreCountries
//
//  Created by Heba on 10/01/2026.
//

import Foundation

enum NetworkError: Error {
    case noInternetConnection
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case httpError(statusCode: Int, body: Data?)
    case other(Error)
}
