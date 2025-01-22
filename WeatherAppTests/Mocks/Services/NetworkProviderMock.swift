//
//  NetworkProviderMock.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

@testable import WeatherApp
import Foundation

class NetworkProviderMock<Data>: NetworkServices {
    
    var data: Data?
    var shouldTriggerErrorOnRead: Bool = false
    
    func fetchData<T>(
        of type: T.Type?,
        with requestGenerator: any RestfulRequestGenerator
    ) async throws -> T? where T : Decodable {
        guard !shouldTriggerErrorOnRead else {
            throw URLError(.badServerResponse)
        }
        
        return data as? T
    }
    
}
