//
//  CityResource.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

@testable import WeatherApp

extension CityResource {
    
    static var medellin: CityResource {
        .init(
            location: Location(
                name: "Medellín",
                region: "Antioquia",
                country: "Colombia",
                lat: 6.2442,
                lon: -75.5812,
                tz_id: "America/Bogota",
                localtime_epoch: 1705912595,  // Replace with the actual epoch time
                localtime: "2025-01-22 09:16" // Replace with the actual local time
            ),
            current: CurrentWeather(
                last_updated_epoch: 1705912595, // Replace with the actual epoch time
                last_updated: "2025-01-22 09:16", // Replace with the actual last updated time
                temp_c: 20.0,
                temp_f: 68.0,
                is_day: 1,
                condition: WeatherCondition(
                    text: "Partly sunny",
                    icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
                    code: 1003
                ),
                wind_mph: 3.0,
                wind_kph: 4.8,
                wind_degree: 0,
                wind_dir: "N",
                pressure_mb: 1015.0,
                pressure_in: 30.0,
                precip_mm: 0.0,
                precip_in: 0.0,
                humidity: 82,
                cloud: 35,
                feelslike_c: 20.0,
                feelslike_f: 68.0,
                windchill_c: nil,
                windchill_f: nil,
                heatindex_c: nil,
                heatindex_f: nil,
                dewpoint_c: 15.0,
                dewpoint_f: 59.0,
                vis_km: 16.0,
                vis_miles: 10.0,
                uv: 6.0,
                gust_mph: 5.0,
                gust_kph: 8.0
            )
        )
    }
    
}
