//
//  CountriesViewModel.swift
//  ExploreCountries
//
//  Created by Heba on 11/01/2026.
//

import Foundation
internal import Combine

@MainActor
final class CountriesViewModel: ObservableObject {
    
    private let api: CountriesAPI
    
    enum State {
        case idle
        case loading
        case loaded([Country])
        case error(message: String)
    }
    
    @Published private(set) var state: State = .idle
    
    var isLoading: Bool {
        if case .loading = state { return true }
        return false
    }
    
    private var loadTask: Task<Void, Never>?
    
    init(api: CountriesAPI) {
        self.api = api
    }
    
    deinit {
        loadTask?.cancel()
    }
    
    func loadCountries() {
        guard !isLoading else { return }
        loadTask?.cancel()
        state = .loading
        
        loadTask = Task { [weak self] in
            guard let self else { return }
            
            do {
                let fields = ["name", "languages", "region", "subregion", "capital", "population", "flags", "currencies"]
                let countries = try await api.getAllCountries(fields: fields)
                self.state = .loaded(countries)
            } catch {
                guard !Task.isCancelled else { return }
                self.state = .error(message: "Failed to load countries.")
            }
        }
    }
}
