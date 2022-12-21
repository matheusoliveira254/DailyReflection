//
//  NetworkController.swift
//  DailyReflection
//
//  Created by Jicell on 12/20/22.
//

import Foundation

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
}
