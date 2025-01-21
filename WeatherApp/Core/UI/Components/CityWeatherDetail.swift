//
//  CityWeatherDetail.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import Foundation
import SwiftUI

struct CityDetailViewModel {
    let imageName: String
    let cityName: String
    let temperature: String
    let humidityTitle: String = "Humidity"
    let humidityValue: String
    let UVTitle: String = "UV"
    let UVValue: String
    let feelsLikeTitle: String = "Feels like"
    let feelsLikeValue: String
}

struct CityWeatherDetail: View {
    let viewModel: CityDetailViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            weatherIcon
            cityContainer
            temperatureContainer
            temperatureDetailContainer
        }
    }
    
    private var weatherIcon: some View {
        Image(systemName: viewModel.imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: Constants.iconSize, height: Constants.iconSize)
            .padding(.bottom, Constants.weatherIconBottomPadding)
    }
    
    private var cityContainer: some View {
        HStack(alignment: .center, spacing: Constants.cityContainerSpacing) {
            Text(viewModel.cityName)
                .customFont(.medium, size: Constants.cityFontSize)
            Image(.vector)
                .frame(width: Constants.vectorSize, height: Constants.vectorSize)
        }
    }
    
    private var temperatureContainer: some View {
        HStack(alignment: .top, spacing: .zero) {
            Text(viewModel.temperature)
                .customFont(.medium, size: Constants.temperatureFontSize)
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
            imageName: "sun.max.fill",
            cityName: "Pune",
            temperature: "45",
            humidityValue: "20%",
            UVValue: "4",
            feelsLikeValue: "38°"
        )
    )
}
