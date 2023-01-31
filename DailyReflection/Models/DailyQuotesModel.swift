//
//  DailyQuotesModel.swift
//  DailyReflection
//
//  Created by Jicell on 12/15/22.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let contents: Contents
}

struct Contents: Decodable, Encodable {
    let quotes: [Quotes]
}

struct Quotes: Decodable, Encodable {
    let quote: String
    let author: String
    let date: String
}

extension Quotes: Equatable {
    static func == (lhs:Quotes, rhs: Quotes) -> Bool {
        return lhs.quote == rhs.quote && rhs.quote == lhs.quote
    }
}
