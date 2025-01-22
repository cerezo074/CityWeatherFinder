//
//  CitySummaryViewModel.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//

import Foundation

class CitySummaryViewModel: ObservableObject {
    
    enum SavingState {
        case saving(message: String)
        case saved
        case error(message: String)
    }
    
    @Published var saveState: SavingState
    
    let cityName: String
    let temperature: String
    let humidityTitle: String = "Humidity"
    let humidityValue: String
    let UVTitle: String = "UV"
    let UVValue: String
    let feelsLikeTitle: String = "Feels like"
    let feelsLikeValue: String
    let iconURL: URL?
    
    var saveCompletion: ThorwableAsyncVoidClousure?
    
    init(
        iconURL: URL?,
        cityName: String,
        temperature: String,
        humidityValue: String,
        UVValue: String,
        feelsLikeValue: String,
        saveState: SavingState = .saving(message: "Saving...")
    ) {
        self.iconURL = iconURL
        self.cityName = cityName
        self.temperature = temperature
        self.humidityValue = humidityValue
        self.UVValue = UVValue
        self.feelsLikeValue = feelsLikeValue
        self.saveState = saveState
    }
    
    init(from city: CityEntity) {
        cityName = city.name
        temperature = String(city.temperature)
        humidityValue = String(city.humidityValue)
        iconURL = city.iconURL
        UVValue = String(city.UVValue)
        feelsLikeValue = String(city.feelsLikeValue)
        saveState = .saving(message: "Saving...")
    }
    
    func viewDidLoad() async {
        do {
            try await saveCompletion?()
            
            await MainActor.run {
                self.saveState = . saved
            }
        } catch {
            print("Error saving city: \(error)")
            await setState(.error(message: "Error saving your city, search again."))
        }
    }
    
    private func setState(_ state: SavingState) async {
        await MainActor.run {
            self.saveState = state
        }
    }
}
