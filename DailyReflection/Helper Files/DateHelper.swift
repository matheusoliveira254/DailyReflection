//
//  DateHelper.swift
//  DailyReflection
//
//  Created by Jicell on 12/22/22.
//

import Foundation

extension Date {
    
    /**
     Extends the Date class giving us the ability to convert a Date to a String.
     */
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    func toString(withFormat format: String = "MM-dd-yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd") -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}

extension DateComponents {
    func toData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
