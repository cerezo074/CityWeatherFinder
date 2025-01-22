//
//  CityEntity.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//

import Foundation

struct CityEntity {
    let cityName: String
    let temperature: Double
    let humidityValue: Int
    let UVValue: Double
    let feelsLikeValue: Double
    let imageURLPath: String
    
    init(
        cityName: String,
        temperature: Double,
        humidityValue: Int,
        UVValue: Double,
        feelsLikeValue: Double,
        imageURLPath: String
    ) {
        self.imageURLPath = imageURLPath
        self.cityName = cityName
        self.temperature = temperature
        self.humidityValue = humidityValue
        self.UVValue = UVValue
        self.feelsLikeValue = feelsLikeValue
    }
    
    init(from city: CityResource) {
        imageURLPath = city.current.condition.icon
        cityName = city.location.name
        temperature = city.current.temp_c
        UVValue = city.current.uv
        humidityValue = city.current.humidity
        feelsLikeValue = city.current.feelslike_c
    }
}
