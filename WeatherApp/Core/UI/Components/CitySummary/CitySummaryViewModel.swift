//
//  CitySummaryViewModel.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 21/01/25.
//

import Foundation

class CitySummaryViewModel: ObservableObject {
    
    enum SavingState: Hashable {
        case saving(message: String)
        case saved
        case error(message: String)
    }
    
    @Published
    private(set)var saveState: SavingState
    
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
    
    init(
        from city: CityEntity,
        saveState: SavingState? = nil
    ) {
        cityName = city.name
        temperature = String(city.temperature)
        humidityValue = String(city.humidityValue)
        iconURL = city.iconURL
        UVValue = String(city.UVValue)
        feelsLikeValue = String(city.feelsLikeValue)
        self.saveState = saveState ?? .saving(message: "Saving...")
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

extension CitySummaryViewModel: Hashable {
    static func == (lhs: CitySummaryViewModel, rhs: CitySummaryViewModel) -> Bool {
        return lhs.cityName == rhs.cityName &&
        lhs.temperature == rhs.temperature &&
        lhs.humidityValue == rhs.humidityValue &&
        lhs.iconURL == rhs.iconURL &&
        lhs.humidityValue == rhs.humidityValue &&
        lhs.feelsLikeValue == rhs.feelsLikeValue &&
        lhs.UVValue == rhs.UVValue &&
        lhs.saveState == rhs.saveState
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(cityName)
        hasher.combine(temperature)
        hasher.combine(humidityValue)
        hasher.combine(iconURL)
        hasher.combine(humidityValue)
        hasher.combine(feelsLikeValue)
        hasher.combine(UVValue)
        hasher.combine(saveState)
    }
}
