//
//  CityWeatherDetail.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import Foundation
import SwiftUI

struct CitySummaryViewModel {
    let cityName: String
    let temperature: String
    let humidityTitle: String = "Humidity"
    let humidityValue: String
    let UVTitle: String = "UV"
    let UVValue: String
    let feelsLikeTitle: String = "Feels like"
    let feelsLikeValue: String
    let iconURL: URL?
    
    init(
        iconURL: URL?,
        cityName: String,
        temperature: String,
        humidityValue: String,
        UVValue: String,
        feelsLikeValue: String
    ) {
        self.iconURL = iconURL
        self.cityName = cityName
        self.temperature = temperature
        self.humidityValue = humidityValue
        self.UVValue = UVValue
        self.feelsLikeValue = feelsLikeValue
    }
    
    init(from city: CityEntity) {
        cityName = city.name
        temperature = String(city.temperature)
        humidityValue = String(city.humidityValue)
        iconURL = city.iconURL
        UVValue = String(city.UVValue)
        feelsLikeValue = String(city.feelsLikeValue)
    }
}

struct CityWeatherDetail: View {
    let viewModel: CitySummaryViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            weatherIcon
            cityContainer
            temperatureContainer
            temperatureDetailContainer
        }
    }
    
    private var weatherIcon: some View {
//        Image(systemName: viewModel.iconURL)
        Image(systemName: "sun.max.fill")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: Constants.iconSize, height: Constants.iconSize)
            .padding(.bottom, Constants.weatherIconBottomPadding)
    }
    
    private var cityContainer: some View {
        HStack(alignment: .center, spacing: Constants.cityContainerSpacing) {
            Text(viewModel.cityName)
                .customFont(.medium, size: Constants.cityFontSize)
                .foregroundStyle(.darkGray)
            Image(.vector)
                .frame(width: Constants.vectorSize, height: Constants.vectorSize)
        }
    }
    
    private var temperatureContainer: some View {
        HStack(alignment: .top, spacing: .zero) {
            Text(viewModel.temperature)
                .customFont(.medium, size: Constants.temperatureFontSize)
                .foregroundStyle(.darkGray)
                .padding(.top, Constants.temperatureTopPadding)
            Image(.bigEllipse)
                .frame(width: Constants.dotSize, height: Constants.dotSize)
                .padding(.top, Constants.dotTopPadding)
                .padding(.leading, Constants.dotLeadingPadding)
        }
        .padding(.bottom, Constants.temperatureBottomPadding)
    }
    
    private var temperatureDetailContainer: some View {
        HStack(alignment: .center, spacing: .zero) {
            makeTemperatureDetail(
                title: viewModel.humidityTitle,
                value: viewModel.humidityValue
            )
            Spacer().frame(width: Constants.detailSpacing)
            makeTemperatureDetail(
                title: viewModel.UVTitle,
                value: viewModel.UVValue
            )
            Spacer().frame(width: Constants.detailSpacing)
            makeTemperatureDetail(
                title: viewModel.feelsLikeTitle,
                showTinyTitle: true,
                value: viewModel.feelsLikeValue
            )
        }
        .padding(.all, Constants.detailContainerPadding)
        .background {
            RoundedRectangle(cornerRadius: Constants.detailContainerCornerRadius).fill(.whiteSmoke)
        }
    }
    
    private func makeTemperatureDetail(
        title: String,
        showTinyTitle: Bool = false,
        value: String
    ) -> some View {
        VStack(alignment: .center) {
            Text(title)
                .customFont(.medium, size: showTinyTitle ? Constants.tinyTitleFontSize : Constants.detailTitleFontSize)
                .foregroundStyle(.silverSand)
            Spacer().frame(maxHeight: Constants.detailTitleBottomSpacing)
            Text(value)
                .customFont(.medium, size: Constants.detailValueFontSize)
                .foregroundStyle(.slateGray)
        }
    }
    
    // MARK: - Constants

    private enum Constants {
        static let temperatureFontSize: CGFloat = 60
        static let temperatureTopPadding: CGFloat = 9
        static let temperatureBottomPadding: CGFloat = 20
        
        static let dotSize: CGFloat = 8
        static let dotTopPadding: CGFloat = 20
        static let dotLeadingPadding: CGFloat = 4
        
        static let iconSize: CGFloat = 123
        static let weatherIconBottomPadding: CGFloat = 27
        
        static let cityFontSize: CGFloat = 30
        static let cityContainerSpacing: CGFloat = 11
        static let vectorSize: CGFloat = 21
        
        static let detailSpacing: CGFloat = 56
        static let detailContainerPadding: CGFloat = 16
        static let detailContainerCornerRadius: CGFloat = 16
        
        static let detailTitleFontSize: CGFloat = 12
        static let tinyTitleFontSize: CGFloat = 8
        static let detailTitleBottomSpacing: CGFloat = 4
        static let detailValueFontSize: CGFloat = 15
    }
}

#Preview {
    CityWeatherDetail(
        viewModel: .init(
            iconURL: URL(string: "https://cdn.weatherapi.com/weather/64x64/day/116.png"),
            cityName: "Pune",
            temperature: "45",
            humidityValue: "20%",
            UVValue: "4",
            feelsLikeValue: "38°"
        )
    )
}
