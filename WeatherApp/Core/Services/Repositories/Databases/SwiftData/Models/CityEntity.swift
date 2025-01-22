//
//  CityEntity.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//

import Foundation
import SwiftData

@Model
final class CityEntity {
    /**
     WARNING
     
     Use a dynamic id property, unique identifier (such as a UUID or city name) to support
     storing multiple cities currently, the implementation allows only a single entity to be,
     inserted which is later updated (upserted) as long as the ID remains unchanged.
     **/
     
    @Attribute(.unique)
    private(set) var id: String = "1"
    private(set) var name: String
    private(set) var temperature: Double
    private(set) var humidityValue: Int
    private(set) var UVValue: Double
    private(set) var feelsLikeValue: Double
    private(set) var imageURLPath: String
    
    var iconURL: URL? {
        // FIXME: Server returns tiny images.
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
