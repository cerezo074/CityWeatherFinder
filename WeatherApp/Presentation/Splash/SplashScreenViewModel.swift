//
//  SplashScreenViewModel.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import Foundation

class SplashScreenViewModel: ObservableObject {
    
    enum ViewState {
        case loading
        case loaded
    }
    
    @Published
    @MainActor
    private(set) var state: ViewState = .loading
    private let didFinishLoading: VoidClousure
    private let cityDataController: CityDataInterface
    
    init(
        cityDataController: CityDataInterface,
        didFinishLoading: @escaping VoidClousure
    ) {
        self.cityDataController = cityDataController
        self.didFinishLoading = didFinishLoading
    }
    
    func viewDidLoad() async {
        await cityDataController.loadContent()
        
        await MainActor.run { [weak self] in
            self?.state = .loaded
            self?.didFinishLoading()
        }
    }
}
