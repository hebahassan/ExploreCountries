//
//  Endpoint.swift
//  ExploreCountries
//
//  Created by Heba on 10/01/2026.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem] { get }
    var body: Data? { get }
}

extension Endpoint {
    func makeRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw NetworkError.invalidURL
        }
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        guard let finalUrl = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers.forEach({
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        })
        
        return request
    }
}
