//
//  CityListViewModel.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import Foundation

class CityListViewModel: ObservableObject {
    
    enum ContentViewState {
        case noResults(title: String, suggestion: String)
        case showSavedCity(_ savedCity: CityDetailViewModel)
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
    private(set) var isSavingCity: Bool = false
    private let noResultsTitle: String = "No City Selected"
    private let noResultsSuggestion: String = "Please Search For A City"
    private let errorTitle: String = "Error"
    
    init(searchText: String, isSearching: Bool, searchPlaceholder: String) {
        self.searchText = searchText
        self.isSearching = isSearching
        self.searchPlaceholder = searchPlaceholder
//        self.contentViewState = .showSavedCity(.init(
//            imageName: "sun.max.fill",
//            cityName: "Pune",
//            temperature: "45",
//            humidityValue: "20%",
//            UVValue: "4",
//            feelsLikeValue: "38°"
//        ))
//        self.contentViewState = .showSuggestedCity(
//            .init(
//                cityName: "Mumbai",
//                temperature: "20",
//                imageName: "sun.max.fill"
//            )
        self.contentViewState = .noResults(title: noResultsTitle, suggestion: noResultsSuggestion
        )
    }
}
