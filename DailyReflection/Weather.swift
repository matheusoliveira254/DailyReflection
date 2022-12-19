//
//  Weather.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/15/22.
//

import Foundation

struct WeatherTopLevelDictionary: Decodable {
    let data: [CurrentWeatherInfo]
}

struct CurrentWeatherInfo: Decodable {
    private enum CodingKeys: String, CodingKey {
        case weather
        case moon = "moon_phase_lunation"
    }
    
    let moon: Double
    let weather: WeatherDictionary
}

struct WeatherDictionary: Decodable {
    let icon: String
}
