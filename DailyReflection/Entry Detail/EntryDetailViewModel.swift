//
//  NewEntryViewModel.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/26/22.
//

import Foundation
import CoreLocation

class EntryDetailViewModel {
    
    var dayScore: Int? = 5
    var weather: String?
    private var entries: [Entry]
    var entry: Entry?
    
    init(entry: Entry?, entries: [Entry]) {
        self.entry = entry
        self.entries = entries
    }
    
    func fetchWeather(currentCity: String, currentState: String, completion: @escaping (String?) -> Void) {
        NetworkController.fetchWeatherInfo(city: currentCity, state: currentState) { result in
            switch result {
            case .success(let weather):
                completion(weather.weatherData.first?.weather.icon)
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }
    
    func createNewEntry(title: String, dayScore: Int, description: String, weather: String) {
        let entry = Entry(title: title, dayScore: dayScore, description: description, weather: weather)
        //Karl said hmm
        entries.insert(entry, at: 0)
        save()
    }
    
    func updateEntry(entry: Entry?, newTitle: String, newDayScore: Int, newDescription: String) {
        guard let entry = entry else {return}
        entry.title = newTitle
        entry.dayScore = newDayScore
        entry.description = newDescription
        save()
    }
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let finalUrl = documentsDirectory.appendingPathComponent("entries.json")
        return finalUrl
    }
    
//    func loadEntries() {
//        guard let loadLocation = fileURL else {return}
//
//        do {
//            let data = try Data(contentsOf: loadLocation)
//            let decodeData = try JSONDecoder().decode([Entry].self, from: data)
//            self.entries = decodeData
//        } catch let error {
//            print("Error \(error)")
//        }
//    }
    
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
