//
//  AppConfig.swift
//  ExploreCountries
//
//  Created by Heba on 11/01/2026.
//

import Foundation

protocol AppConfig {
    var apiBaseURL: URL { get }
}

struct AppConfigImpl: AppConfig {
    let apiBaseURL: URL
    
    init(bundle: Bundle = .main) {
        guard
            let value = bundle.object(forInfoDictionaryKey: "API_BASE_URL") as? String,
            let url = URL(string: value) else {
            fatalError("Can't find URL key")
        }
        
        self.apiBaseURL = url
    }
}
