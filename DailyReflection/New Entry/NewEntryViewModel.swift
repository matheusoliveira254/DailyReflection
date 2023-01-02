//
//  NewEntryViewModel.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/26/22.
//

import Foundation
import CoreLocation

class NewEntryViewModel {
    
    var weather: WeatherDictionary?
    private var entries: [Entry] = []
    
    func fetchWeather(currentCity: String, currentState: String) {
        NetworkController.fetchWeatherInfo(city: currentCity, state: currentState) { result in
            switch result {
            case .success(let weather):
                self.weather = weather.weather
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createNewEntry(title: String, dayScore: String, description: String, weather: String) {
        let entry = Entry(title: title, dayScore: "\(dayScore)/5", description: description, weather: weather)
        loadEntries()
        entries.insert(entry, at: 0)
        save()
    }
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let finalUrl = documentsDirectory.appendingPathComponent("entries.json")
        return finalUrl
    }
    
    func loadEntries() {
        guard let loadLocation = fileURL else {return}
        
        do {
            let data = try Data(contentsOf: loadLocation)
            let decodeData = try JSONDecoder().decode([Entry].self, from: data)
            self.entries = decodeData
        } catch let error {
            print("Error \(error)")
        }
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
