//
//  CountriesService.swift
//  ExploreCountries
//
//  Created by Heba on 15/01/2026.
//

import Foundation

protocol CountriesService {
    func getCountries() async throws -> [Country]
}

final class CountriesServiceImpl: CountriesService {
    private let api: CountriesAPI
    private let cache: CountriesDiskCache
    
    init(api: CountriesAPI, cache: CountriesDiskCache = CountriesDiskCache()) {
        self.api = api
        self.cache = cache
    }
    
    func getCountries() async throws -> [Country] {
        if let cached = cache.load(), !cached.isEmpty {
            print("from cache..")
            return cached
        }
        
        let fields = ["name", "languages", "region", "subregion", "capital", "population", "flags", "currencies"]
        let countries = try await api.getAllCountries(fields: fields)
        print("from api..")
        
        cache.save(countries)
        
        return countries
    }
}
