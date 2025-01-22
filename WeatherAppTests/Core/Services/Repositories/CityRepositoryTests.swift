//
//  CityRepositoryTests.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Testing
import Foundation
@testable import WeatherApp

struct CityRepositoryTests {
    private let networkProviderMock = NetworkProviderMock<CityResource>()
    private let cityDBMock = CityDBMock()
    
    private lazy var repository: CityRepository = {
        CityRepository(
            networkProvider: networkProviderMock,
            weatherAPIKey: "",
            database: cityDBMock
        )
    }()
    
    @Test
    mutating func getCity_withValidQuery_returnsEntity() async throws {
        networkProviderMock.data = .medellin
        
        let result = try await repository.getCity(by: "mede")
        
        #expect(result == .medellin)
    }
    
    @Test("When there is a network exception the repository returns nil")
    mutating func getCity_whenBadServerResponse_returnsNil() async throws {
        networkProviderMock.shouldTriggerErrorOnRead = true
        
        let result = try await repository.getCity(by: "mede")
        
        #expect(result == nil)
    }
    
    @Test("Is database is well configured the repository saves the city")
    mutating func save_whenDatabaseIsOK_finishMethod() async throws {
        try await repository.save(city: .medellin)
        
        #expect(cityDBMock.inMemoryData.first == .medellin)
    }
    
    @Test("When there is a database exception the repository raises an exception")
    mutating func save_withDatabaseError_raiseException() async throws {
        cityDBMock.shouldTriggerErrorOnCreate = true
        
        
        await #expect {
            try await repository.save(city: .medellin)
        } throws: { error in
            guard let dbError = error as? CityDBMock.Errors else {
                return false
            }
            return dbError == .conectionError
        }
    }
    
    @Test("If there is no read error on database the repository sets the last saved city")
    mutating func loadContent_withNoReadError_setLastSavedCity() async throws {
        cityDBMock.inMemoryData = [.medellin]
        
        try await repository.loadContent()
    }
    
    @Test("When there is a read error on database the repository raises an exception")
    mutating func loadContent_withReadError_raiseException() async throws {
        cityDBMock.shouldTriggerErrorOnRead = true
                
        await #expect(throws: CityDBMock.Errors.conectionError.self) {
            try await repository.loadContent()
        }
    }
    
    @Test
    mutating func getLastSavedCity_withSuccessLoadContent_returnsValue() async throws {
        cityDBMock.inMemoryData = [.medellin]
        try await repository.loadContent()
        
        let lastSavedCity = await repository.getLastSavedCity()
        
        #expect(lastSavedCity == .medellin)
    }
    
    @Test
    mutating func getLastSavedCity_withoutLoadContent_returnsNilValue() async throws {
        cityDBMock.inMemoryData = [.medellin]
        
        let lastSavedCity = await repository.getLastSavedCity()
        
        #expect(lastSavedCity == nil)
    }
}
