//
//  CityEntity.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

@testable import WeatherApp

extension CityEntity {

    static var medellin: CityEntity {
        .init(
            name: "Medellín",
            temperature: 20.0,
            humidityValue: 82,
            UVValue: 6.0,
            feelsLikeValue: 20.0,
            imageURLPath: "//cdn.weatherapi.com/weather/64x64/day/116.png"
        )
    }
    
}
