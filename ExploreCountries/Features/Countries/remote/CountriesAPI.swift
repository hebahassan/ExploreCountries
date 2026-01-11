//
//  CountriesAPI.swift
//  ExploreCountries
//
//  Created by Heba on 11/01/2026.
//

import Foundation

protocol CountriesAPI {
    func getAllCountries(fields: [String]) async throws -> [Country]
}

final class CountriesAPIImpl: CountriesAPI {
    private let client: NetworkClient
    
    init(client: NetworkClient) {
        self.client = client
    }
    
    func getAllCountries(fields: [String]) async throws -> [Country] {
        try await client.request(CountriesEndpoint.all(fields: fields)) as [Country]
    }
}
