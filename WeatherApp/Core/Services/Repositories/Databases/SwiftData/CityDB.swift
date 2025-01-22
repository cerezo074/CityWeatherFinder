//
//  CityDB.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import SwiftData

final class CityDB: SwiftDatabase {
    
    typealias T = CityEntity
    
    let container: ModelContainer
    
    /// Use an in-memory store to store non-persistent data when unit testing
    ///
    init(useInMemoryStore: Bool = false) throws {
        let configuration = ModelConfiguration(for: CityEntity.self, isStoredInMemoryOnly: useInMemoryStore)
        print("SQLite Database location: \(configuration.url)")
        container = try ModelContainer(for: CityEntity.self, configurations: configuration)
    }
}
