//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import SwiftUI

@main
struct WeatherApp: App {
    
    @StateObject private var appCoordinator: AppCoordinator
    
    init() {
        self._appCoordinator = .init(wrappedValue: .init())
    }
    
    var body: some Scene {
        WindowGroup {
            AppContentView(appCoordinator: appCoordinator)
        }
    }
}
