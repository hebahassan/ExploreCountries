//
//  Country.swift
//  ExploreCountries
//
//  Created by Heba on 09/01/2026.
//

import Foundation

struct Country: Codable, Identifiable {
    var id = UUID()
    let region: String
    let subregion: String?
    let population: Int
    let flags: Flags
    let currencies: [String: Currency]
    let languages: [String: String]
    let capital: [String]
    let name: Name
}

extension Country {
    static let dummy: [Country] = [
        Country(
            id: UUID(),
            region: "Americas",
            subregion: "Caribbean",
            population: 103603,
            flags: Flags(
                png: "https://flagcdn.com/w320/ag.png",
                svg: "https://flagcdn.com/ag.svg",
                alt: "The flag of Antigua and Barbuda has a red field with an inverted isosceles triangle based on the top edge and spanning the height of the field. This triangle has three horizontal bands of black, light blue and white, with the light blue band half the height of the two other bands. The top half of a golden-yellow sun is situated in the lower two-third of the black band to depict a rising sun."
            ),
            currencies: ["XCD" : Currency(name: "Eastern Caribbean dollar", symbol: "$")],
            languages: ["eng":"English"],
            capital: ["St. John's"],
            name: Name(common: "Antigua and Barbuda", official: "Antigua and Barbuda"),
        ),
        Country(
            id: UUID(),
            region: "Americas",
            subregion: "Caribbean",
            population: 103603,
            flags: Flags(
                png: "https://flagcdn.com/w320/ag.png",
                svg: "https://flagcdn.com/ag.svg",
                alt: "The flag of Antigua and Barbuda has a red field with an inverted isosceles triangle based on the top edge and spanning the height of the field. This triangle has three horizontal bands of black, light blue and white, with the light blue band half the height of the two other bands. The top half of a golden-yellow sun is situated in the lower two-third of the black band to depict a rising sun."
            ),
            currencies: ["XCD" : Currency(name: "Eastern Caribbean dollar", symbol: "$")],
            languages: ["eng":"English"],
            capital: ["St. John's"],
            name: Name(common: "Antigua and Barbuda", official: "Antigua and Barbuda"),
        ),
    ]
}
