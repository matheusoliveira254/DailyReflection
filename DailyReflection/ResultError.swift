//
//  ResultError.swift
//  DailyReflection
//
//  Created by Jicell on 12/20/22.
//

import Foundation

enum ResultError: LocalizedError {
    
    case requestError(Error)
    case badURL
    case noData
    case couldNotUnwrap
    case errorDecoding
 
    
    
    var errorDescription: String? {
        switch self {
        case .requestError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .badURL:
            return "Unable to reach the server. Please try again."
        case .noData:
            return "No Data."
        case .couldNotUnwrap:
            return "The server responded with no data. Please try again."
        case .errorDecoding:
            return "The server responded with bad data. Please try again."
     
        }
    }
}
