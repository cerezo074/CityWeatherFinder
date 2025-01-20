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
    
    init(didFinishLoading: @escaping VoidClousure) {
        self.didFinishLoading = didFinishLoading
    }
    
    func viewDidLoad() async {
        
        // TODO: Call use case for loading data from disk
        try? await Task.sleep(for: .seconds(3))
        
        await MainActor.run { [weak self] in
            self?.state = .loaded
            self?.didFinishLoading()
        }
    }
}
