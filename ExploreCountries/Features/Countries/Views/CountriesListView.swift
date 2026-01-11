//
//  ContentView.swift
//  ExploreCountries
//
//  Created by Heba on 09/01/2026.
//

import SwiftUI

struct CountriesListView: View {
    @State private var searchText = ""
    @StateObject private var viewModel: CountriesViewModel

    init(viewModel: CountriesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            content
        }
        .navigationTitle("Explore Countries")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: "Search by name or region")
        .task {
            viewModel.loadCountries()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading, .idle:
            ProgressView()
        case .loaded(let countries):
            List(countries) { country in
                HStack (spacing: 12) {
                    AsyncImage(url: URL(string: country.flags?.png ?? "")) { phase in
                        switch (phase) {
                        case .success(let image):
                            image.resizable().scaledToFill()
                            
                        default:
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.quaternary)
                        }
                    }
                    .frame(width: 45, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    VStack(alignment: .leading) {
                        if let commonName = country.name?.common {
                            Text(commonName)
                                .font(.headline)
                        }
                        
                        if let region = country.region {
                            Text(region)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                    }
                    
                    Spacer()
                    
                    Image(systemName: "star")
                }
                .padding(.vertical, 4)
            }
        case .error(let message):
            VStack {
                Text(message)
                    .foregroundColor(.red)
            }
        }
    }
}
