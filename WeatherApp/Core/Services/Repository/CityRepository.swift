//
//  CityRepository.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//

protocol CityRepositoryInteface {
    func getCity(by name: String) async throws -> CityEntity?
}

actor CityRepository: CityRepositoryInteface {
    
    private var networkProvider: NetworkServices
    private let weatherAPIKey: String
    
    init(networkProvider: NetworkServices, weatherAPIKey: String) {
        self.networkProvider = networkProvider
        self.weatherAPIKey = weatherAPIKey
    }
    
    func getCity(by name: String) async throws -> CityEntity? {
        let endpoint = CityEndpointTypes.searchCity(query: name, apiKey: weatherAPIKey)
        let remoteResource = try await networkProvider.fetchData(
            of: CityResource.self,
            with: endpoint
        )
        
        print(remoteResource)
        
        return nil
    }
}
