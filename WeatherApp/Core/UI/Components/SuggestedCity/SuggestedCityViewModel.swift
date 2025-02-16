//
//  SuggestedCityViewModel.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 23/01/25.
//

import Foundation

struct SuggestedCityViewModel: Hashable {
    let cityName: String
    let temperature: String
    let iconURL: URL?
}
