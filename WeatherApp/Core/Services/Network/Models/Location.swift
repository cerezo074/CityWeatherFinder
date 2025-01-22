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
    
    init(
        name: String = "",
        region: String = "",
        country: String = "",
        lat: Double = 0.0,
        lon: Double = 0.0,
        tz_id: String = "",
        localtime_epoch: Int = 0,
        localtime: String = ""
    ) {
        self.name = name
        self.region = region
        self.country = country
        self.lat = lat
        self.lon = lon
        self.tz_id = tz_id
        self.localtime_epoch = localtime_epoch
        self.localtime = localtime
    }
}
