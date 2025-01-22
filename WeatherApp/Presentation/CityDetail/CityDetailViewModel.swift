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
    private var foundCity: CityEntity?
    private var summaryViewModel: CitySummaryViewModel?
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
    
    func didTapSuggestedCity() async {
        guard let suggestedCity = foundCity else { return }
        let summaryViewModel: CitySummaryViewModel = .init(from: suggestedCity)
        
        summaryViewModel.saveCompletion = { [weak self] in
            guard let self else { return }
            try await cityFinder.save(city: suggestedCity)
        }
        
        await setState(.showSavedCity(summaryViewModel))
        self.summaryViewModel = summaryViewModel
    }
    
    private func onSearchData(with cityName: String) async {
        do {
            if let foundCity = try await cityFinder.searchCity(by: cityName) {
                await handleSuggestedCity(with: foundCity)
            } else {
                await setState(
                    .error(title: errorTitle, description: "City not found, use a different name")
                )
            }
        } catch {
            // TODO: Handle errors properly by reading their content.
            print("Error retrieving city by name \(cityName) and error: \(error)")
            
            await setState(
                .error(title: errorTitle, description: "City not found, use a different name")
            )
        }
    }
                           
    private func handleSuggestedCity(with foundCity: CityEntity) async {
        await setState(.showSuggestedCity(
            .init(
                cityName: foundCity.name,
                temperature: String(foundCity.temperature),
                iconURL: foundCity.iconURL
            )
        ))
        
        self.foundCity = foundCity
    }
    
    private func setState(_ newState: ContentViewState) async {
        await MainActor.run {
            self.contentViewState = newState
        }
    }
}
