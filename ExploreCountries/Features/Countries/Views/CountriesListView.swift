//
//  ContentView.swift
//  ExploreCountries
//
//  Created by Heba on 09/01/2026.
//

import SwiftUI

struct CountriesListView: View {
    @State private var searchText = ""
    @State private var countries: [Country] = Country.dummy
    
    var body: some View {
        List(countries) { country in
            HStack (spacing: 12) {
                AsyncImage(url: URL(string: country.flags.png)) { phase in
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
                    Text(country.name.common)
                        .font(.headline)
                    
                    Text(country.region)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        
                }
                
                Spacer()
                
                Image(systemName: "star")
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Explore Countries")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: "Search by name or region")
    }
}

#Preview {
    CountriesListView()
}
