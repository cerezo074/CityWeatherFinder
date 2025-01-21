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
                searchPlaceholder: Constants.searchPlaceholder
            )
        )
    }
    
    var body: some View {
        VStack {
            searchView
            Spacer().ifLet(topContentViewSpace) { view, value in
                view.frame(height: value)
            }
            contentView
            Spacer()
        }
    }
    
    var topContentViewSpace: CGFloat? {
        switch viewModel.contentViewState {
        case .showSavedCity:
            Constants.topContentSpaceSavedCity
        case .showSuggestedCity:
            Constants.topContentSpaceSuggestedCity
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
        .padding(.horizontal, Constants.searchPaddingHorizontal)
        .padding(.top, Constants.searchPaddingTop)
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.contentViewState {
        case .noResults(let title, let suggestion):
            showMessage(with: title, description: suggestion)
                .foregroundStyle(Constants.noResultsTextColor)
        case .error(let title, let message):
            showMessage(with: title, description: message)
                .foregroundStyle(Constants.errorTextColor)
        case .showSavedCity(let city):
            CityWeatherDetail(viewModel: city)
        case .showSuggestedCity(let city):
            CitySuggestion(viewModel: city)
                .padding(.horizontal, Constants.suggestionPaddingHorizontal)
        }
    }
    
    private func showMessage(
        with title: String,
        description: String
    ) -> some View {
        VStack(spacing: Constants.messageSpacing) {
            Text(title)
                .customFont(.semiBold, size: Constants.messageTitleFontSize)
            Text(description)
                .customFont(.semiBold, size: Constants.messageDescriptionFontSize)
        }
    }
    
    // MARK: - Constants

    private enum Constants {
        static let searchPlaceholder = "Search Location"
        static let searchPaddingHorizontal: CGFloat = 24
        static let searchPaddingTop: CGFloat = 44
        
        static let topContentSpaceSavedCity: CGFloat = 74
        static let topContentSpaceSuggestedCity: CGFloat = 32
        
        static let noResultsTextColor: Color = .darkGray
        static let errorTextColor: Color = .red
        static let suggestionPaddingHorizontal: CGFloat = 24
        
        static let messageSpacing: CGFloat = 8
        static let messageTitleFontSize: CGFloat = 30
        static let messageDescriptionFontSize: CGFloat = 15
    }
}

#Preview {
    CityListView()
}
