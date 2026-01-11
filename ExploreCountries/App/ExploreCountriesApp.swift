//
//  ExploreCountriesApp.swift
//  ExploreCountries
//
//  Created by Heba on 09/01/2026.
//

import SwiftUI

@main
struct ExploreCountriesApp: App {
    private let container = AppContainer()
    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: container.makeCountriesViewModel()) 
        }
    }
}
