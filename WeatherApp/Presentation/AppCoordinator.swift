//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import Foundation
import SwiftUI

class AppCoordinator: ObservableObject {
    
    enum AppState {
        case onStartup
        case home
    }
    
    @Published
    var baseNavigationPath: NavigationPath
    @Published
    private(set) var appState: AppState
    
    init() {
        self.baseNavigationPath = .init()
        self.appState = .onStartup
    }
    
    @ViewBuilder
    func makeView() -> some View {
        switch appState {
        case .onStartup:
            SplashScreenView { [weak self] in
                self?.finishedStartup()
            }
        case .home:
            CityListView()
        }
    }
    
    private func finishedStartup() {
        appState = .home
    }
}
