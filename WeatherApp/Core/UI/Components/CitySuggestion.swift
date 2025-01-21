//
//  CitySuggestion.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import SwiftUI

struct SuggestedCityViewModel {
    let cityName: String
    let temperature: String
    let imageName: String
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
                .padding(.top, Constants.titleTopPadding)
            temperatureContainer
        }
    }
    
    private var temperatureContainer: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(viewModel.temperature)
                .customFont(.medium, size: Constants.temperatureFontSize)
            Image(.ellipse)
                .frame(width: Constants.dotSize, height: Constants.dotSize)
                .padding(.top, Constants.dotTopPadding)
                .padding(.leading, Constants.dotLeadingPadding)
        }
    }
    
    private var weatherIcon: some View {
        Image(systemName: viewModel.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: Constants.iconWidth, height: Constants.iconHeight)
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
    }
}

#Preview {
    CitySuggestion(
        viewModel: .init(
            cityName: "Mumbai",
            temperature: "20",
            imageName: "sun.max.fill"
        )
    ).padding(.horizontal, 20)
}
