//
//  CityRepository.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//

protocol CityRepositoryInteface {
    func getLastSavedCity() async -> CityEntity?
    func getCity(by name: String) async throws -> CityEntity?
    func save(city: CityEntity) async throws
    func loadContent() async throws
}

actor CityRepository: CityRepositoryInteface {
    
    private let networkProvider: NetworkServices
    private let weatherAPIKey: String
    private let database: any CityDataBaseInterface
    private var lastSavedCity: CityEntity?
    
    init(
        networkProvider: NetworkServices,
        weatherAPIKey: String,
        database: any CityDataBaseInterface
    ) {
        self.networkProvider = networkProvider
        self.weatherAPIKey = weatherAPIKey
        self.database = database
    }
    
    func getCity(by name: String) async throws -> CityEntity? {
        let endpoint = CityEndpointTypes.searchCity(query: name, apiKey: weatherAPIKey)
        
        guard let remoteResource = try await networkProvider.fetchData(
            of: CityResource.self,
            with: endpoint
        ) else {
            return nil
        }
        
        let cityEntity = CityEntity(from: remoteResource)
        
        return cityEntity
    }
    
    func save(city: CityEntity) async throws {
        try database.create(city)
    }
    
    func loadContent() async throws {
        lastSavedCity = try database.read(sortBy: []).first
    }
    
    func getLastSavedCity() async -> CityEntity? {
        return lastSavedCity
    }
}
