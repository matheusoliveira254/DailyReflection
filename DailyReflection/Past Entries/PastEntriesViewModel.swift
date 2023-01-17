//
//  PastEntriesViewModel.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 1/11/23.
//

import Foundation

class PastEntriesViewModel {
    var storage: EntryStorable
    let calendar = Calendar.current
    
    init(storage: EntryStorable = EntryStorage.sharedInstance) {
        self.storage = storage
        let grouping = storage.entries.chunked(into: 7)
        self.storage.groupedEntries = grouping
    }
}//End of class
