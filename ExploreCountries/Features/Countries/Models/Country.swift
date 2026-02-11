//
//  Country.swift
//  ExploreCountries
//
//  Created by Heba on 09/01/2026.
//

import Foundation

struct Country: Codable, Identifiable, Hashable {
    var id: String { cca2 }
    
    let cca2: String
    let region: String?
    let subregion: String?
    let population: Int?
    let flags: Flags?
    let currencies: [String: Currency]?
    let languages: [String: String]?
    let capital: [String]?
    let name: Name?
    
    private enum CodingKeys: String, CodingKey {
        case region, subregion, population, flags, currencies, languages, capital, name, cca2
    }
    
    func getPopulationNumber() -> String {
        guard let population else { return "Unknown" }
        return "\(population)"
    }
}

extension Country {
    static let dummy: [Country] = [
        Country(
            cca2: "AB",
            region: "Americas",
            subregion: "Caribbean",
            population: 103603,
            flags: Flags(
                png: "https://flagcdn.com/w320/ag.png",
                svg: "https://flagcdn.com/ag.svg",
            ),
            currencies: ["XCD" : Currency(name: "Eastern Caribbean dollar", symbol: "$")],
            languages: ["eng":"English"],
            capital: ["St. John's"],
            name: Name(common: "Antigua and Barbuda", official: "Antigua and Barbuda"),
        ),
        Country(
            cca2: "BC",
            region: "Americas",
            subregion: "Caribbean",
            population: 103603,
            flags: Flags(
                png: "https://flagcdn.com/w320/ag.png",
                svg: "https://flagcdn.com/ag.svg",
            ),
            currencies: ["XCD" : Currency(name: "Eastern Caribbean dollar", symbol: "$")],
            languages: ["eng":"English"],
            capital: ["St. John's"],
            name: Name(common: "Antigua and Barbuda", official: "Antigua and Barbuda"),
        ),
    ]
}
