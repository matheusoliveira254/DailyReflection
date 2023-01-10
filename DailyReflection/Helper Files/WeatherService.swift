//
//  WeatherService.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 1/9/23.
//

import Foundation

class WeatherService {
    var weather: WeatherTopLevelDictionary?
    
    func fetchWeather(currentCity: String, currentState: String) {
        NetworkController.fetchWeatherInfo(city: currentCity, state: currentState) { result in
            switch result {
            case .success(let weather):
                self.weather = weather
                UserDefaults.standard.set(weather.weatherData.first?.weather.icon, forKey: "weather")
            case .failure(let error):
                print(error)
            }
        }
    }
}//End of class
