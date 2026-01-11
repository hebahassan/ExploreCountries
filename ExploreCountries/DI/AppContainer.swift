//
//  AppContainer.swift
//  ExploreCountries
//
//  Created by Heba on 11/01/2026.
//

import Foundation

final class AppContainer {
    let config: AppConfig
    
    init(config: AppConfig = AppConfigImpl()) {
        self.config = config
    }
    
    lazy var networkClient: NetworkClient = {
        URLSessionNetworkClient(baseURL: config.apiBaseURL)
    }()
    
    lazy var countriesAPI: CountriesAPI = {
        CountriesAPIImpl(client: networkClient)
    }()
    
    func makeCountriesViewModel() -> CountriesViewModel {
        CountriesViewModel(api: countriesAPI)
    }
}
