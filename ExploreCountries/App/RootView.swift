//
//  RootView.swift
//  ExploreCountries
//
//  Created by Heba on 09/01/2026.
//

import SwiftUI

struct RootView: View {
    private let countriesViewModel: CountriesViewModel

    init(viewModel: CountriesViewModel) {
        self.countriesViewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            CountriesListView(viewModel: countriesViewModel)
        }
    }
}

#Preview {
    RootView(viewModel: CountriesViewModel(service: PreviewCountriesService()))
}
