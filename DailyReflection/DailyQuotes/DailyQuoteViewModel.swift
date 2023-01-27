//
//  DailyQuoteViewModel.swift
//  DailyReflection
//
//  Created by Jicell on 12/21/22.
//

import Foundation
//Implementing a protocol with and updateViews function
protocol DailyQuoteViewModelDelegate: AnyObject {
  func updateViews()
}

// dailyQuotesViewModel class that will handle the business logic
class DailyQuoteViewModel {
 // Properties
    var dailyQuoteData: TopLevelDictionary? // Created dailyQuoteData: TopLevelDictionary first level of JSON
    var tempQuoteArray: [Quotes] = [] // this property holds the temporary quotes
    var content: Contents?

    // Here i'm conforming to the protocol
    weak var delegate: DailyQuoteViewModelDelegate?
    
    //Delegate is being initialized (Here we are injecting dependency from the view model into this view controller because this view should not exist without its view model.
    init( delegate: DailyQuoteViewModelDelegate) {
        self.delegate = delegate
    }
    
    //created the fetchDailyQuoteData func to fetch the quotes
     func fetchDailyQuoteData() {
         //loadQuotes is being assaigned to tempQuoteArray
     tempQuoteArray = loadQuotes(url: URL.quotesDoc)
         print(tempQuoteArray)
       
         //Here we are checking if our completion was a success or a feilure
         NetworkController.fetchQod { result in
            switch result {
            case .success(let dailyQuoteData):
                //here dailyQuoteData is being append to tempQuoteArray
                print(self.tempQuoteArray.count)
                // creted a for in to will loop into tempQuoteArray 
                    for temp in self.tempQuoteArray {
                        //this will check if dailyQuoteData.contents.quotes
                        if (dailyQuoteData.contents.quotes[0].quote == temp.quote) {
                            self.delegate?.updateViews()
                            return
                        }
                }
                self.tempQuoteArray.insert(dailyQuoteData.contents.quotes[0], at: 0)
                self.saveQuotes(quotes: self.tempQuoteArray)
                self.delegate?.updateViews()
            case .failure(let error):
                print("Error fetching the data!", error.errorDescription)
            }
        }
    }
    
    func saveQuotes(quotes: [Quotes]) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(quotes)
            try data.write(to: .quotesDoc, options:[.atomic, .completeFileProtection])
        } catch {
            print("Error saving quotes\(error)")
        }
    }
    
    func loadQuotes(url: URL) ->[Quotes] {

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Quotes].self, from: data)
        } catch {
            print("Error loading quotes\(error)")
            return []
        }
    }
}//End of class.

extension URL {
    static let quotesDoc = URL.documentsDirectory.appending(component: "quotesInfo").appendingPathExtension("json")
}
