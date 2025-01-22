//
//  EmptyCityDataController.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//


class EmptyCityDataController: CityDataInterface {
    func save(city: CityEntity) async throws {
        
    }
    
    func searchCity(by name: String) async throws -> CityEntity? {
        nil
    }
    
    func loadContent() async {
        
    }
    
    func getLastCitySearched() async -> CityEntity? {
        return nil
    }
}