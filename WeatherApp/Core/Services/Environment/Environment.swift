//
//  Environment.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//

import Foundation

enum Environment {
    case production
    case staging
    
    // TODO: This value should come from a trusted server DO NOT STORE SENSIBLE INFORMATION IN CODE!!!
    var weatherApiKey: String {
        switch self {
        case .production, .staging:
            return ProcessInfo.processInfo.environment["WEATHER_API_KEY"] ?? ""
        }
    }
}
