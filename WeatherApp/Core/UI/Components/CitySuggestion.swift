//
//  CitySuggestion.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import SwiftUI
import Kingfisher

struct SuggestedCityViewModel {
    let cityName: String
    let temperature: String
    let iconURL: URL?
}

struct CitySuggestion: View {
    let viewModel: SuggestedCityViewModel
    
    var body: some View {
        HStack {
            informationContainer
            Spacer()
            weatherIcon
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .background {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(.whiteSmoke)
        }
    }
    
    private var informationContainer: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(viewModel.cityName)
                .customFont(.semiBold, size: Constants.titleFontSize)
                .foregroundStyle(.darkGray)
                .padding(.top, Constants.titleTopPadding)
            temperatureContainer
        }
    }
    
    private var temperatureContainer: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(viewModel.temperature)
                .customFont(.medium, size: Constants.temperatureFontSize)
                .foregroundStyle(.darkGray)
            Image(.ellipse)
                .frame(width: Constants.dotSize, height: Constants.dotSize)
                .padding(.top, Constants.dotTopPadding)
                .padding(.leading, Constants.dotLeadingPadding)
        }
    }
    
    @ViewBuilder
    private var weatherIcon: some View {
        if let iconURL = viewModel.iconURL {
            KFImage(iconURL)
                .placeholder {
                    weatherPlaceholder
                }
                .resizable()
                .scaledToFill()
                .frame(width: Constants.iconWidth, height: Constants.iconWidth)
        } else {
            weatherPlaceholder
        }
    }
    
    private var weatherPlaceholder: some View {
        Image(systemName: Constants.iconPlaceholderName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: Constants.iconWidth, height: Constants.iconWidth)
            .foregroundStyle(.yellow)
    }
    
    // MARK: - Constants

    private enum Constants {
        static let horizontalPadding: CGFloat = 31
        static let cornerRadius: CGFloat = 16
        static let iconWidth: CGFloat = 83
        static let iconHeight: CGFloat = 63
        static let titleFontSize: CGFloat = 20
        static let titleTopPadding: CGFloat = 14
        static let temperatureFontSize: CGFloat = 60
        static let dotSize: CGFloat = 5
        static let dotTopPadding: CGFloat = 20
        static let dotLeadingPadding: CGFloat = 8
        static let iconPlaceholderName: String = "sun.max.fill"
    }
}

#Preview {
    CitySuggestion(
        viewModel: .init(
            cityName: "Mumbai",
            temperature: "20",
            iconURL: URL(string: "https://cdn.weatherapi.com/weather/64x64/day/116.png")
        )
    )
    .padding(.horizontal, 20)
}
