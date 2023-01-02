//
//  EntriesListViewModel.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/29/22.
//

import Foundation

class EntryListViewModel {
    
    var entries: [Entry] = []
    
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
    
    func deleteEntry() {
        
    }
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let finalUrl = documentsDirectory.appendingPathComponent("entries.json")
        return finalUrl
    }
}
