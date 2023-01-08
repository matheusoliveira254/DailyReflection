//
//  EntriesListViewModel.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/29/22.
//

import Foundation

class EntryListViewModel {
    
    var storage: EntryStorable
    
    init(storage: EntryStorable = EntryStorage.sharedInstance) {
        self.storage = storage
        loadEntries()
    }
    
    func loadEntries() {
        storage.load()
    }
    
    func deleteEntry(index: Int) {
        storage.entries.remove(at: index)
        storage.update()
    }
}//End of class
