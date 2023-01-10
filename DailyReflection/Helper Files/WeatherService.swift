//
//  WeatherService.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 1/9/23.
//

import Foundation

class WeatherService {
    var weather: String? = "sun.max.fill"
    
    func fetchWeather(currentCity: String, currentState: String) {
        NetworkController.fetchWeatherInfo(city: currentCity, state: currentState) { result in
            switch result {
            case .success(let weather):
                self.weather = weather.weatherData.first?.weather.icon
            case .failure(let error):
                print(error)
            }
        }
    }
}//End of class
