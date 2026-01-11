//
//  PreviewCountriesAPI.swift
//  ExploreCountries
//
//  Created by Heba on 11/01/2026.
//

import Foundation

struct PreviewCountriesAPI: CountriesAPI {
    func getAllCountries(fields: [String]) async throws -> [Country] {
        Country.dummy
    }
}
