//
//  CountryDetailsView.swift
//  ExploreCountries
//
//  Created by Heba on 23/01/2026.
//

import SwiftUI

struct CountryDetailsView: View {
    let country: Country
    @Environment(FavoritesManager.self) private var favoritesManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let flagPng = country.flags?.png, let flagUrl = URL(string: flagPng) {
                AsyncImage(url: flagUrl) { phase in
                    switch phase {
                    case .empty:
                        ProgressView().tint(.white)
                    case .success(let image):
                        image.resizable().scaledToFit()
                    case .failure(_):
                        fallbackImage
                    @unknown default:
                        fallbackImage
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                .padding(.vertical, 20)
                .shadow(radius: 10)
            } else {
                fallbackImage
            }
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                InfoCard(title: "Population", value: country.getPopulationNumber(), icon: "person.3.fill")
                InfoCard(title: "Region", value: country.region ?? "Unknown", icon: "globe")
                InfoCard(title: "Capital", value: country.capital?.first ?? "Unknown", icon: "building.2.fill")
                InfoCard(title: "Languages", value: country.languages?.values.first ?? "Unknown", icon: "bubble.left.and.exclamationmark.bubble.right.fill")
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color(red: 138/255, green: 154/255, blue: 91/255, opacity: 0.5))
        .navigationTitle(country.name?.official ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    favoritesManager.toggle(country.id)
                } label: {
                     Image(systemName: favoritesManager.isFavorite(country.id) ? "star.fill" : "star")
                        .foregroundStyle(.yellow)
                }
            }
        }
        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
    }
    
    var fallbackImage: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(.white.opacity(0.10))

            Text("🏳️")
                .font(.system(size: 90))
        }
    }
}
