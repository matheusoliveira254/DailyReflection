//
//  NetworkController.swift
//  DailyReflection
//
//  Created by Jicell on 12/20/22.
//

import UIKit

struct NetworkController {
    private static let baseURLString = "https://quotes.rest/qod"
    
    static func fetchQod(completion: @escaping (Result<TopLevelDictionary, ResultError>) -> Void) {
        
        guard let baseUrl = URL(string: baseURLString) else {
            return
        }
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        
        let languageQuery = URLQueryItem(name: "language", value: "en")
        
        components?.queryItems = [languageQuery]
        guard let finalURL = components?.url else {
            return
        }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error {
                completion(.failure(.requestError(error)))
            }
            guard let quoteData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let quoteOfDay = try JSONDecoder().decode(TopLevelDictionary.self, from: quoteData)
                completion(.success(quoteOfDay))
                
            } catch {
                completion(.failure(.errorDecoding))
            }
        }.resume()
    }
    
    static func fetchWeatherInfo(city: String?, state: String?, completion: @escaping (Result<WeatherTopLevelDictionary, ResultError>) -> Void) {
        
        guard let city = city?.replacingOccurrences(of: " ", with: "_") else {return}
        guard let state = state else {return}
        let WeatherUrl = "https://api.weatherbit.io/v2.0/current/daily?city=\(city),\(state)&key=7592672ff4534749b7736a1c4f5e30f3"
        guard let finalWeatherUrl = URL(string: WeatherUrl) else {completion(.failure(.badURL)); return}
        
        URLSession.shared.dataTask(with: finalWeatherUrl) { data, _, error in
            if let error {
                completion(.failure(.requestError(error)))
                return
            }
            
            guard let weatherData = data else {completion(.failure(.noData)); return}
            
            do {
                let currentWeather = try JSONDecoder().decode(WeatherTopLevelDictionary.self, from: weatherData)
                completion(.success(currentWeather))
            } catch {
                completion(.failure(.errorDecoding))
            }
        }.resume()
    }
}//End of struct
