//
//  CountriesDiskCache.swift
//  ExploreCountries
//
//  Created by Heba on 15/01/2026.
//

import Foundation

struct CountriesDiskCache {
    private let fileURL: URL
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(
        fileName: String = "countries_cache.json",
        fileManager: FileManager = .default,
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder()
    ) {
        let dir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        self.fileURL = dir.appendingPathComponent(fileName)
        self.decoder = decoder
        self.encoder = encoder
    }
    
    func save(_ countries: [Country]) {
        guard let data = try? encoder.encode(countries) else { return }
        try? data.write(to: fileURL, options: [.atomic])
    }
    
    func load() -> [Country]? {
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return try? decoder.decode([Country].self, from: data)
    }
    
    mutating func clear() {
        try? FileManager.default.removeItem(at: fileURL)
    }
}
