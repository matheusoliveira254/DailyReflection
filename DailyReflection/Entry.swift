//
//  Entry.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/20/22.
//

import Foundation

class Entry {
    
    enum Keys {
        static let entries = "entries"
        static let title = "title"
        static let dayScore = "dayScore"
        static let description = "description"
        static let weather = "weather"
        static let moon = "moon"
        static let date = "date"
        static let uuid = "uuid"
    }
    
    var title: String
    var dayScore: String
    var description: String
    var weather: String
    var moon: Double
    var date: Date
    var uuid: String
    
    var entryData: [String: AnyHashable] {
        [Keys.title: self.title,
         Keys.dayScore: self.dayScore,
         Keys.description: self.description,
         Keys.weather: self.weather,
         Keys.moon: self.moon,
         Keys.date: self.date,
         Keys.uuid: self.uuid
        ]
    }
    
    init(title: String, dayScore: String, description: String, weather: String, moon: Double, date: Date = Date(), uuid: String = UUID().uuidString) {
        self.title = title
        self.dayScore = dayScore
        self.description = description
        self.weather = weather
        self.moon = moon
        self.date = date
        self.uuid = uuid
    }
}//End of class

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
