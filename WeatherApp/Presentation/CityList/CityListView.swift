//
//  CityListView.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import SwiftUI

struct CityListView: View {
    
    @StateObject private var viewModel: CityListViewModel
    
    init() {
        self._viewModel = .init(
            wrappedValue: .init(
                searchText: "",
                isSearching: false,
                searchPlaceholder: "Search Location"
            )
        )
    }
    
    var body: some View {
        VStack {
            searchView
            Spacer().ifLet(topContentSpace) { view, value in
                view.frame(height: value)
            }
            contentView
            Spacer()
        }
    }
    
    var topContentSpace: CGFloat? {
        switch viewModel.contentViewState {
        case .showSavedCity:
            74
        case .showSuggestedCity:
            32
        case .error, .noResults:
            nil
        }
    }
    
    private var searchView: some View {
        SearchBar(
            text: $viewModel.searchText,
            isLoading: viewModel.isSearching,
            placeholder: viewModel.searchPlaceholder
        )
        .disabled(viewModel.isSavingCity)
        .padding(.horizontal, 24)
        .padding(.top, 44)
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.contentViewState {
        case .noResults(let title, let suggestion):
            showMessage(with: title, description: suggestion)
                .foregroundStyle(.darkGray)
        case .error(let title, let message):
            showMessage(with: title, description: message)
                .foregroundStyle(.red)
        case .showSavedCity(let city):
            CityWeatherDetail(viewModel: city)
        case .showSuggestedCity(let city):
            CitySuggestion(viewModel: city)
                .padding(.horizontal, 24)
        }
    }
    
    private func showMessage(
        with title: String,
        description: String
    ) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .customFont(.semiBold, size: 30)
            Text(description)
                .customFont(.semiBold, size: 15)
        }
    }
}

#Preview {
    CityListView()
}
