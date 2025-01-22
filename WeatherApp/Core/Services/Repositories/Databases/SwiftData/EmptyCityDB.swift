//
//  EmptyCityDB.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 8/01/25.
//

import Foundation

class EmptyCityDB: Database {
    
    typealias T = CityEntity
    
    init () {
        assertionFailure("Using EmptyDatabase is not recommended as fallback for release code")
    }
    
    func create(_ item: CityEntity) throws {
        
    }
    
    func create(_ items: [CityEntity]) throws {

    }
    
    func read(
        sortBy sortDescriptors: [SortDescriptor<CityEntity>]
    ) throws -> [CityEntity] {
        return []
    }
    
    func update(_ item: CityEntity) throws {
        
    }
    
    func delete(_ item: CityEntity) throws {
        
    }
}
