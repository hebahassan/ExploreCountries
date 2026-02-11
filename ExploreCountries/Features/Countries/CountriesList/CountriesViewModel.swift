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
    
    private let service: CountriesService
    
    enum State {
        case idle
        case loading
        case loaded([Country])
        case error(message: String)
    }
    
    @Published private(set) var state: State = .idle
    @Published var searchText: String = ""
    
    var filteredCountries: [Country] {
        guard case .loaded(let countries) = state else {
            return []
        }

        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter { country in
                country.name?.common?.localizedCaseInsensitiveContains(searchText) ?? false ||
                (country.region?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }
    
    var isLoading: Bool {
        if case .loading = state { return true }
        return false
    }
    
    private var loadTask: Task<Void, Never>?
    
    init(service: CountriesService) {
        self.service = service
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
                let countries = try await service.getCountries()
                self.state = .loaded(countries)
            } catch {
                guard !Task.isCancelled else { return }
                self.state = .error(message: mapErrorToMessage(error))
            }
        }
    }
    
    private func mapErrorToMessage(_ error: Error) -> String {
        if let networkError = error as? NetworkError {
            switch networkError {
            case .noInternetConnection:
                return "It looks like you're offline. Please check your internet connection."
            case .invalidURL, .invalidResponse, .decodingError:
                return "Something went wrong. Please try again later."
            case .httpError(let statusCode, _):
                if (500...599).contains(statusCode) { return "Server error. Please try again later." }
                return "Request failed (code \(statusCode)). Please try again later."
            case .other(_):
                return "Failed to load countries."
            }
        }
        
        return "Failed to load countries."
    }
}
