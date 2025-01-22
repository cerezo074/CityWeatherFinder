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
    private let cityFinder: CityDataInterface
    
    init(
        cityFinder: CityDataInterface,
        didFinishLoading: @escaping VoidClousure
    ) {
        self.cityFinder = cityFinder
        self.didFinishLoading = didFinishLoading
    }
    
    func viewDidLoad() async {
        await cityFinder.loadContent()
        
        await MainActor.run { [weak self] in
            self?.state = .loaded
            self?.didFinishLoading()
        }
    }
}
