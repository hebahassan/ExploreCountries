//
//  ContentView.swift
//  ExploreCountries
//
//  Created by Heba on 09/01/2026.
//

import SwiftUI

struct CountriesListView: View {
    @StateObject private var viewModel: CountriesViewModel
    @State private var selectedCountry: Country?

    init(viewModel: CountriesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                content
            }
            .navigationTitle("Explore Countries")
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: "Search by name or region")
            .task {
                viewModel.loadCountries()
            }
        }
        .background(Color(red: 138/255, green: 154/255, blue: 91/255, opacity: 0.5))
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading, .idle:
            ProgressView()
        case .loaded:
            List(viewModel.filteredCountries) { country in
                NavigationLink {
                    CountryDetailsView(country: country)
                } label: {
                    CountryRow(country: country)
                }
                .listRowBackground(Color.white.opacity(0.5))
                .listRowSeparatorTint(Color.gray.opacity(0.2))
            }
            .scrollContentBackground(.hidden)
        case .error(let message):
            VStack {
                Text(message)
                    .foregroundColor(.red)
            }
        }
    }
}
