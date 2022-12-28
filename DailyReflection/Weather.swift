//
//  Weather.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/15/22.
//

import Foundation

struct WeatherTopLevelDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case weatherData = "data"
    }
    let weatherData: [CurrentWeatherInfo]
}

struct CurrentWeatherInfo: Decodable {
    let weather: WeatherDictionary
}

struct WeatherDictionary: Decodable {
    let icon: String
}
