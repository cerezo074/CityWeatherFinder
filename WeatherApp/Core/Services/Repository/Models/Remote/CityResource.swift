//
//  CityResource.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//

import Foundation

struct CityResource: Decodable {
    let location: Location
    let current: CurrentWeather
}
