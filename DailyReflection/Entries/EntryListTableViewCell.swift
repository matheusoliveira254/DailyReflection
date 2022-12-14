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
    
    func configure() {
        entryTitleEntryListCellLabel.text = "First Day"
        entryDateEntryListCellLabel.text = "12/14/2022"
        dayScoreEntryListCellLabel.text = "5/5"
    }
}
