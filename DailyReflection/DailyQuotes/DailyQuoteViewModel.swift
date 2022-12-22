//
//  DailyQuoteViewModel.swift
//  DailyReflection
//
//  Created by Jicell on 12/21/22.
//

import Foundation

protocol DailyQuoteViewModelDelegate: AnyObject {
  func updateViews()
}

class DailyQuoteViewModel {
    var dailyQuoteData: TopLevelDictionary?
    var content: [Quotes] {
        self.dailyQuoteData?.contents.quotes ?? []
    }
    weak var delegate: DailyQuoteViewModelDelegate?
//     private let networkController = NetworkController()
    
    init( delegate: DailyQuoteViewModelDelegate) {
        self.delegate = delegate
    }
    
     func fetchDailyQuoteData() {
         NetworkController.fetchQod { result in
            switch result {
            case .success(let dailyQuoteData):
                self.dailyQuoteData = dailyQuoteData
                self.delegate?.updateViews()
            case .failure(let error):
                print("Error fetching the data!",
                      error.errorDescription)
            }
        }
    }
    
}//End of class.

