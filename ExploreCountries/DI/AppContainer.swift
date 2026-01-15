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
    
    lazy var countriesService: CountriesService = {
       CountriesServiceImpl(api: countriesAPI)
    }()
    
    func makeCountriesViewModel() -> CountriesViewModel {
        CountriesViewModel(service: countriesService)
    }
}
