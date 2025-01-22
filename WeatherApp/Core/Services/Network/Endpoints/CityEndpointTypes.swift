//
//  CityEndpointTypes.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 22/01/25.
//

import Foundation

protocol RestfulRequestGenerator {
    func makeRequest() -> URLRequest?
}

enum CityEndpointTypes: RestfulRequestGenerator {
    case searchCity(query: String, apiKey: String)
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.weatherapi.com"
    }
    
    
    var headers: [String: String] {
        switch self {
        case .searchCity:
            return ["Content-Type": "application/json"]
        }
    }
    
    var path: String {
        switch self {
        case .searchCity:
            return "/v1/current.json"
        }
    }
    
    var method: RestfulEndpoint.HTTPMethod {
        switch self {
        case .searchCity:
            return .get
        }
    }

    var queryParams: [String: String]{
        switch self {
        case .searchCity(let query, let apiKey):
            return [
                "key" : apiKey,
                "q": query
            ]
        }
    }
    
    func makeRequest() -> URLRequest? {
        RestfulEndpoint(
            scheme: scheme,
            host: host,
            path: path,
            method: method,
            queryParams: queryParams,
            headers: headers
        ).makeURLRequest()
    }
}
