//
//  CountriesEndpoint.swift
//  ExploreCountries
//
//  Created by Heba on 11/01/2026.
//

import Foundation

enum CountriesEndpoint: Endpoint {
    case all(fields: [String])
    
    var path: String { "/v3.1/all" }
    var method: HTTPMethod { .get }
    var headers: [String : String] { ["Accept": "application/json"] }
    var body: Data? { nil }
    var queryItems: [URLQueryItem] {
        switch self {
        case .all(let fields):
            guard !fields.isEmpty else { return [] }
            return [URLQueryItem(name: "fields", value: fields.joined(separator: ","))]
        }
    }
}
