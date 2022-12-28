//
//  NewEntryViewModel.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/26/22.
//

import Foundation

class NewEntryViewModel {
    
    var weather: WeatherDictionary?
    private(set) var entries: [Entry] = []
    
    func fetchWeather(location: String?) {
        NetworkController.fetchWeatherInfo(location: location) { result in
            switch result {
            case .success(let weather):
                self.weather = weather.weather
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createNewEntry(title: String, dayScore: String, description: String, weather: String) {
        let entry = Entry(title: title, dayScore: dayScore, description: description, weather: weather)
        entries.append(entry)
        save()
    }
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let finalUrl = documentsDirectory.appendingPathComponent("entries.json")
        return finalUrl
    }
    
    func save() {
        guard let url = fileURL else {return}
        
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: url)
        } catch let error {
            print("Error \(error)")
        }
    }
}//End of class
