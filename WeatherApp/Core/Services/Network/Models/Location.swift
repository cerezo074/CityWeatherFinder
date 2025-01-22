//
//  Location.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//


struct Location: Decodable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tz_id: String
    let localtime_epoch: Int
    let localtime: String
}