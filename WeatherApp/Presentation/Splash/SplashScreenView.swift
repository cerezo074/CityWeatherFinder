//
//  SplashScreenView.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import SwiftUI

struct SplashScreenView: View {
    
    @StateObject private var viewModel: SplashScreenViewModel
    
    init(
        cityDataController: CityDataInterface,
        didFinishLoading: @escaping VoidClousure
    ) {
        self._viewModel = .init(
            wrappedValue: .init(
                cityDataController: cityDataController,
                didFinishLoading: didFinishLoading
            )
        )
    }
    
    var body: some View {
        switch viewModel.state {
        case .loaded:
            VStack {
                logo.padding(.bottom, 20)
                Text("Data has loaded!!!")
                    .customFont(.regular, size: 20)
            }
        case .loading:
            VStack {
                logo.padding(.bottom, 20)
                ProgressView("Loading data...")
                    .customFont(.regular, size: 20)
            }.task {
                await viewModel.viewDidLoad()
            }
        }
    }
    
    private var logo: some View {
        VStack {
            Text("The Weather App")
                .customFont(.bold, size: 50)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            Image(systemName: "cloud.sun.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
        }
    }
}

#Preview {
    SplashScreenView(cityDataController: EmptyCityDataController(), didFinishLoading: {})
}
