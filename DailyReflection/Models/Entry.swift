//
//  Entry.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/20/22.
//

import Foundation

class Entry: Codable {
    
    var title: String
    var dayScore: Int
    var description: String
    var weather: String
//    var moon: Double
    var date: Date
    var uuid: String
    
    init(title: String, dayScore: Int, description: String, weather: String, /*moon: Double, */date: Date = Date(), uuid: String = UUID().uuidString) {
        self.title = title
        self.dayScore = dayScore
        self.description = description
        self.weather = weather
//        self.moon = moon
        self.date = date
        self.uuid = uuid
    }
}//End of class

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
