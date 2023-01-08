//
//  NewEntryViewModel.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/26/22.
//

import Foundation
import CoreLocation

class EntryDetailViewModel {
    
    private let locationService = LocationService()
    var dayScore: Int? = 5
    var weather: String?
    var storage: EntryStorable
    var entry: Entry?
    var entryIndex: Int?
    
    init(entry: Entry? = nil, entryIndex: Int? = nil, storage: EntryStorable = EntryStorage.sharedInstance) {
        self.entry = entry
        self.storage = storage
        self.entryIndex = entryIndex
    }
    
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
    
    func saveEntry(title: String, dayScore: Int, description: String, weather: String?) {
        if entry != nil {
            updateEntry(newTitle: title, newDayScore: dayScore, newDescription: description)
        } else {
            guard let weather = weather else {return}
            let entry = Entry(title: title, dayScore: dayScore, description: description, weather: weather)
            self.storage.save(entry)
        }
    }
    
    private func updateEntry(newTitle: String, newDayScore: Int, newDescription: String) {
        guard let entry = entry, let entryIndex = entryIndex else {return}
        let entryToUpdate = storage.entries[entryIndex]
        entryToUpdate.title = newTitle
        entryToUpdate.dayScore = newDayScore
        entryToUpdate.description = newDescription
        storage.update()
    }
}//End of class
