//
//  EntryListTableViewCell.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/14/22.
//

import UIKit

class EntryListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherIconEntryListCellImageView: UIImageView!
    @IBOutlet weak var entryTitleEntryListCellLabel: UILabel!
    @IBOutlet weak var entryDateEntryListCellLabel: UILabel!
    @IBOutlet weak var dayScoreEntryListCellLabel: UILabel!
    @IBOutlet weak var moonIconEntryListImageView: UIImageView!
    
    func configure(title: String, date: String, rating: String) {
        entryTitleEntryListCellLabel.text = title
        entryDateEntryListCellLabel.text = date
        dayScoreEntryListCellLabel.text = rating
    }
}
