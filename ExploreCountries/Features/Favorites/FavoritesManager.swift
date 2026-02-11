//
//  FavoritesManager.swift
//  ExploreCountries
//
//  Created by Heba on 11/02/2026.
//

import Foundation

@MainActor
@Observable
class FavoritesManager {
    private(set) var favoriteIDs: Set<String> = [] {
        didSet {
            saveChanges()
        }
    }
    
    private let saveKey = "favorites_key"
    
    init() {
        if let saved = UserDefaults.standard.stringArray(forKey: saveKey) {
            favoriteIDs = Set(saved)
        }
    }
    
    private func saveChanges() {
        UserDefaults.standard.set(Array(favoriteIDs), forKey: saveKey)
    }
    
    func isFavorite(_ countryID: String) -> Bool {
        favoriteIDs.contains(countryID)
    }
    
    func toggle(_ countryID: String) {
        if !favoriteIDs.insert(countryID).inserted {
            favoriteIDs.remove(countryID)
        }
    }
}
