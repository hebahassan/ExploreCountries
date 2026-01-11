//
//  URLSessionNetworkClient.swift
//  ExploreCountries
//
//  Created by Heba on 10/01/2026.
//

import Foundation

final class URLSessionNetworkClient: NetworkClient {
    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(
        baseURL: URL,
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = try endpoint.makeRequest(baseURL: baseURL)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let http = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard (200..<300).contains(http.statusCode) else {
                throw NetworkError.httpError(statusCode: http.statusCode, body: data)
            }
            
            do {
                print("BODY:", String(data: data, encoding: .utf8) ?? "nil")
                return try decoder.decode(T.self, from: data)
            } catch {
                print("ERROR: decoding error, \(error.localizedDescription)")
                throw NetworkError.decodingError(error)
            }
        } catch {
            if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                throw NetworkError.noInternetConnection
            }
            
            throw NetworkError.other(error)
        }
    }
}
