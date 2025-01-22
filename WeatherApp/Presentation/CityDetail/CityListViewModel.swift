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
    
    let searchPlaceholder: String
    
    @Published
    private(set) var contentViewState: ContentViewState
    @Published
    var searchText: String = ""
    @Published
    private(set) var isSearching: Bool = false
    @Published
    private(set) var disableSearch: Bool = false
    @Published
    private(set) var isSavingCity: Bool = false
    private var subscriptions = Set<AnyCancellable>()
    private let noResultsTitle: String = "No City Selected"
    private let noResultsSuggestion: String = "Please Search For A City"
    private let errorTitle: String = "Error"
    private let cityFinder: CityDataInterface
    
    init(
        searchText: String,
        isSearching: Bool,
        searchPlaceholder: String,
        cityFinder: CityDataInterface
    ) {
        self.searchText = searchText
        self.isSearching = isSearching
        self.searchPlaceholder = searchPlaceholder
        self.contentViewState = .noResults(title: noResultsTitle, suggestion: noResultsSuggestion)
        self.cityFinder = cityFinder
    }
    
    func viewDidLoad() async {
        // TODO: Load a saved city if exists
        $searchText
            .dropFirst()
            .removeDuplicates()
            .handleEvents(receiveOutput: {  value in
                Task { [weak self] in
                    await self?.showSearchAnimation(!value.isEmpty)
                }
            })
            .debounce(for: .seconds(3), scheduler: DispatchQueue.global())
            .sink { [weak self] text in
                self?.onSearchData(with: text)
        }
        .store(in: &subscriptions)
    }
    
    private func onSearchData(with cityName: String) {
        Task {
            await showSearchAnimation(!cityName.isEmpty)
            guard !cityName.isEmpty else {                
                return
            }
            await enableSearch(false)
            
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
            
            await showSearchAnimation(false)
            await enableSearch(true)
        }
    }
    
    private func showSearchAnimation(_ show: Bool) async {
        await MainActor.run {
            isSearching = show
        }
    }
    
    private func enableSearch(_ enabled: Bool) async {
        await MainActor.run {
            disableSearch = !enabled
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
