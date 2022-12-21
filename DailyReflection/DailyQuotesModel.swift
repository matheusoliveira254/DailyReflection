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
struct Contents: Decodable {
    let quotes: [Quotes]
}

struct Quotes: Decodable {
    let quote: String
    let author: String
}
