//
//  EditEntryViewModel.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 1/4/23.
//

import Foundation

protocol EditEntryViewModelDelegate: AnyObject {
    func updateViews()
}

class EditEntryViewModel {
    
    weak var delegate: EditEntryViewModelDelegate?
    var dayScoreEdited: String?
    var entryToBeEdited: Entry? 
    
    init(delegate: EditEntryViewModelDelegate?) {
        self.delegate = delegate
    }
}//End of Class
