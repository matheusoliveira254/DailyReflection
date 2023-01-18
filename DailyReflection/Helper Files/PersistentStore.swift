//
//  PersistentStore.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 1/5/23.
//

import Foundation

protocol EntryStorable {
    var entries: [Entry] {get set}
    var groupedEntries: [[Entry]] {get set}
    func save(_ entry: Entry)
    func update()
    func load()
    func groupEntries()
}

class EntryStorage: EntryStorable {
    static let sharedInstance = EntryStorage()
    var entries: [Entry] = []
    var groupedEntries: [[Entry]] = [[]]
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let finalUrl = documentsDirectory.appendingPathComponent("entries.json")
        return finalUrl
    }
    
    func save(_ entry: Entry) {
        guard let url = fileURL else {return}
        
        do {
            entries.insert(entry, at: 0)
            let data = try JSONEncoder().encode(entries)
            try data.write(to: url)
        } catch let error {
            print("Error \(error)")
        }
    }
    
    func update() {
        guard let url = fileURL else {return}
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: url)
        } catch let error {
            print("Error \(error)")
        }
    }
    
    func load() {
        guard let url = fileURL else {return}
        do {
            let data = try Data(contentsOf: url)
            let entries = try JSONDecoder().decode([Entry].self, from: data)
            self.entries = entries
        } catch let error {
            print("Error \(error)")
        }
    }
    
    func groupEntries() {
        groupedEntries = entries.chunked(into: 7)
    }
}//End of Class

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
