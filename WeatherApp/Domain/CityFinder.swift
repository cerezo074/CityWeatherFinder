//
//  CityFinder.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//

protocol CityDataInterface {
    func searchCity(by name: String) async throws -> CityEntity?
    func save(city: CityEntity) async throws
}

class CityDataController: CityDataInterface {
    
    private var savedCityEntity: CityEntity?
    private let repository: CityRepositoryInteface
    
    init(
        savedCityEntity: CityEntity? = nil,
        repository: CityRepositoryInteface? = nil
    ) {
        self.savedCityEntity = savedCityEntity
        self.repository = repository ?? CityRepository(
            networkProvider: NetworkController(),
            weatherAPIKey: Environment.staging.weatherApiKey,
            database: (try? CityDB()) ?? EmptyCityDB()
        )
    }
    
    func searchCity(by name: String) async throws -> CityEntity? {
        try await repository.getCity(by: name)
    }
    
    func save(city: CityEntity) async throws {
        try await repository.save(city: city)
    }
    
}

class EmptyCityDataController: CityDataInterface {
    func save(city: CityEntity) async throws {
        
    }
    
    func searchCity(by name: String) async throws -> CityEntity? {
        nil
    }
    
}
