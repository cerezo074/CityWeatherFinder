//
//  WeatherCondition.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//


struct WeatherCondition: Decodable {
    let text: String
    let icon: String
    let code: Int
    
    init(
        text: String = "",
        icon: String = "",
        code: Int = 0
    ) {
        self.text = text
        self.icon = icon
        self.code = code
    }
}
