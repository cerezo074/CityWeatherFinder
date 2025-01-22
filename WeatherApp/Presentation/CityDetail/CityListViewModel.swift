//
//  CityDetailViewModel.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import Foundation
import Combine

class CityDetailViewModel: ObservableObject {
    
    enum ContentViewState {
        case noResults(title: String, suggestion: String)
        case showSavedCity(_ savedCity: CitySummaryViewModel)
        case showSuggestedCity(_ suggestedCity: SuggestedCityViewModel)
        case error(title: String, description: String)
    }
    
    @Published
    private(set) var contentViewState: ContentViewState
   
    @Published
    private(set) var isSavingCity: Bool = false
    private var subscriptions = Set<AnyCancellable>()
    private let noResultsTitle: String = "No City Selected"
    private let noResultsSuggestion: String = "Please Search For A City"
    private let errorTitle: String = "Error"
    private let cityFinder: CityDataInterface
    let searchViewModel: SearchViewModel
    
    init(
        searchText: String,
        isSearching: Bool,
        searchPlaceholder: String,
        cityFinder: CityDataInterface
    ) {
        self.contentViewState = .noResults(title: noResultsTitle, suggestion: noResultsSuggestion)
        self.cityFinder = cityFinder
        self.searchViewModel = .init(
            text: searchText,
            isLoading: isSearching,
            placeholder: searchPlaceholder
        )
        
        searchViewModel.searchCompletion = { [weak self] query in
            guard let self else { return }
            await self.onSearchData(with: query)
        }
    }
    
    func viewDidLoad() async {
        await searchViewModel.viewDidLoad()
    }
    
    private func onSearchData(with cityName: String) async {
        do {
            if let foundCity = try await cityFinder.searchCity(by: cityName) {
                print(foundCity)
                // TODO: Map the city
            } else {
                await displayQueryError(with: "City not found, use a different name")
            }
        } catch {
            print("Error retrieving city by name \(cityName) and error: \(error)")
            await displayQueryError(with: "We could not find the city you searched for. Please try again.")
        }
    }
    
    private func displayQueryError(with message: String) async {
        await MainActor.run {
            self.contentViewState = .error(
                title: errorTitle,
                description: "We could not find the city you searched for. Please try again."
            )
        }
    }
}
