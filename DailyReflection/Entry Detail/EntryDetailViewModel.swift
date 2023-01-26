//
//  NewEntryViewModel.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/26/22.
//

import Foundation
import CoreLocation

class EntryDetailViewModel {
    
    private let weatherService = WeatherService()
    private let locationService = LocationService()
    var dayScore: Int? = 5
    var storage: EntryStorable
    var entry: Entry?
    
    init(entry: Entry? = nil, storage: EntryStorable = EntryStorage.sharedInstance) {
        self.entry = entry
        self.storage = storage
    }
    
    func saveEntry(title: String, dayScore: Int, description: String) {
        if entry != nil {
            updateEntry(newTitle: title, newDayScore: dayScore, newDescription: description)
        } else {
            let weather = UserDefaults.standard.string(forKey: "weather")
            let entry = Entry(title: title, dayScore: dayScore, description: description, weather: weather ?? "sun.max.fill" )
            self.storage.save(entry)
        }
    }
    
    private func updateEntry(newTitle: String, newDayScore: Int, newDescription: String) {
        guard let entry = entry, let entryToUpdate = storage.entries.first(where: {$0.uuid == entry.uuid}) else {return}
        entryToUpdate.title = newTitle
        entryToUpdate.dayScore = newDayScore
        entryToUpdate.description = newDescription
        storage.update()
    }
}//End of class
