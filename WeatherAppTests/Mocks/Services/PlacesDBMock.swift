//
//  PlacesDBMock.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation
@testable import WeatherApp

class CityDBMock: Database {
    
    typealias T = CityEntity

    enum Errors: Error, LocalizedError {
        case notFound
        case conectionError
        
        var errorDescription: String? {
            switch self {
            case .notFound:
                return "Item Not Found"
            case .conectionError:
                return "A Connection could not be established with the Database"
            }
        }
    }
    
    var inMemoryData: [CityEntity] = []
    var shouldTriggerErrorOnRead: Bool = false
    var shouldTriggerErrorOnCreate: Bool = false

    func create(_ item: CityEntity) throws {
        if shouldTriggerErrorOnCreate {
            throw Errors.conectionError
        }
        
        inMemoryData.append(item)
    }
    
    func create(_ items: [CityEntity]) throws {
        if shouldTriggerErrorOnCreate {
            throw Errors.conectionError
        }
        
        inMemoryData.append(contentsOf: items)
    }
    
    func read(sortBy sortDescriptors: [SortDescriptor<CityEntity>]) throws -> [CityEntity] {
        if shouldTriggerErrorOnRead {
            throw Errors.conectionError
        }
        
        return inMemoryData
    }
    
    func update(_ item: CityEntity) throws {
        guard let itemIndex = inMemoryData.firstIndex(of: item) else {
            try create(item)
            return
        }
        
        inMemoryData[itemIndex] = item
    }
    
    func delete(_ item: CityEntity) throws {
        guard let itemIndex = inMemoryData.firstIndex(
            where: { $0.id == item.id }
        ) else {
            throw Errors.notFound
        }
        
        inMemoryData.remove(at: itemIndex)
    }
    
}
