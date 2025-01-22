//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//


struct CurrentWeather: Decodable {
    let last_updated_epoch: Int
    let last_updated: String
    let temp_c: Double
    let temp_f: Double
    let is_day: Int
    let condition: WeatherCondition
    let wind_mph: Double
    let wind_kph: Double
    let wind_degree: Int
    let wind_dir: String
    let pressure_mb: Double
    let pressure_in: Double
    let precip_mm: Double
    let precip_in: Double
    let humidity: Int
    let cloud: Int
    let feelslike_c: Double
    let feelslike_f: Double
    let windchill_c: Double?
    let windchill_f: Double?
    let heatindex_c: Double?
    let heatindex_f: Double?
    let dewpoint_c: Double
    let dewpoint_f: Double
    let vis_km: Double
    let vis_miles: Double
    let uv: Double
    let gust_mph: Double
    let gust_kph: Double
    
    init(
        last_updated_epoch: Int = 0,
        last_updated: String = "",
        temp_c: Double = 0.0,
        temp_f: Double = 0.0,
        is_day: Int = 0,
        condition: WeatherCondition = WeatherCondition(text: "", icon: "", code: 0),
        wind_mph: Double = 0.0,
        wind_kph: Double = 0.0,
        wind_degree: Int = 0,
        wind_dir: String = "",
        pressure_mb: Double = 0.0,
        pressure_in: Double = 0.0,
        precip_mm: Double = 0.0,
        precip_in: Double = 0.0,
        humidity: Int = 0,
        cloud: Int = 0,
        feelslike_c: Double = 0.0,
        feelslike_f: Double = 0.0,
        windchill_c: Double? = nil,
        windchill_f: Double? = nil,
        heatindex_c: Double? = nil,
        heatindex_f: Double? = nil,
        dewpoint_c: Double = 0.0,
        dewpoint_f: Double = 0.0,
        vis_km: Double = 0.0,
        vis_miles: Double = 0.0,
        uv: Double = 0.0,
        gust_mph: Double = 0.0,
        gust_kph: Double = 0.0
    ) {
        self.last_updated_epoch = last_updated_epoch
        self.last_updated = last_updated
        self.temp_c = temp_c
        self.temp_f = temp_f
        self.is_day = is_day
        self.condition = condition
        self.wind_mph = wind_mph
        self.wind_kph = wind_kph
        self.wind_degree = wind_degree
        self.wind_dir = wind_dir
        self.pressure_mb = pressure_mb
        self.pressure_in = pressure_in
        self.precip_mm = precip_mm
        self.precip_in = precip_in
        self.humidity = humidity
        self.cloud = cloud
        self.feelslike_c = feelslike_c
        self.feelslike_f = feelslike_f
        self.windchill_c = windchill_c
        self.windchill_f = windchill_f
        self.heatindex_c = heatindex_c
        self.heatindex_f = heatindex_f
        self.dewpoint_c = dewpoint_c
        self.dewpoint_f = dewpoint_f
        self.vis_km = vis_km
        self.vis_miles = vis_miles
        self.uv = uv
        self.gust_mph = gust_mph
        self.gust_kph = gust_kph
    }
}
