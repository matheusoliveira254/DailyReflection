//
//  PastEntriesCollectionViewCell.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 1/11/23.
//

import UIKit

class PastEntriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pastEntriesDateRangeLabel: UILabel!
    
    func configure(entryArray: [Entry]) {
        guard let firstObjectDate = entryArray.first?.date,
              let lastObjectDate = entryArray.last?.date else {return}
        pastEntriesDateRangeLabel.text = "From: \(lastObjectDate.toString()) To: \(firstObjectDate.toString())"
    }
}
