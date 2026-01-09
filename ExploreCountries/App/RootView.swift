//
//  RootView.swift
//  ExploreCountries
//
//  Created by Heba on 09/01/2026.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            CountriesListView()
        }
    }
}

#Preview {
    RootView()
}
