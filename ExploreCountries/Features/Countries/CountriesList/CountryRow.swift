//
//  CoutryRow.swift
//  ExploreCountries
//
//  Created by Heba on 11/02/2026.
//

import SwiftUI

struct CountryRow: View {
    let country: Country
    @Environment(FavoritesManager.self) private var favoritesManager
    
    var body: some View {
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
            
            Button {
                favoritesManager.toggle(country.id)
            } label: {
                Image(systemName: favoritesManager.isFavorite(country.id) ? "star.fill" : "star")
                    .foregroundStyle(.yellow)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(
                favoritesManager.isFavorite(country.id) ? "Add To Favorites" : "Remove From Favorites"
            )
        }
        .padding(.vertical, 4)
    }
}
