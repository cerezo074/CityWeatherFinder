//
//  CityEntity.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//

import Foundation

struct CityEntity {
    let name: String
    let temperature: Double
    let humidityValue: Int
    let UVValue: Double
    let feelsLikeValue: Double
    private let imageURLPath: String
    
    var iconURL: URL? {
        return URL(string: "https:\(imageURLPath)")
    }
    
    init(
        name: String,
        temperature: Double,
        humidityValue: Int,
        UVValue: Double,
        feelsLikeValue: Double,
        imageURLPath: String
    ) {
        self.imageURLPath = imageURLPath
        self.name = name
        self.temperature = temperature
        self.humidityValue = humidityValue
        self.UVValue = UVValue
        self.feelsLikeValue = feelsLikeValue
    }
    
    init(from city: CityResource) {
        imageURLPath = city.current.condition.icon
        name = city.location.name
        temperature = city.current.temp_c
        UVValue = city.current.uv
        humidityValue = city.current.humidity
        feelsLikeValue = city.current.feelslike_c
    }
}
