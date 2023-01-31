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
    
    func configure(entry: Entry?) {
        guard let entry = entry else {return}
        entryTitleEntryListCellLabel.text = entry.title
        entryDateEntryListCellLabel.text = entry.date.toString()
        dayScoreEntryListCellLabel.text = "\(entry.dayScore)/5"
        if entry.weather != "sun.max.fill" {
            weatherIconEntryListCellImageView.image = UIImage(named: entry.weather)
        } else {
            weatherIconEntryListCellImageView.image = UIImage(systemName: entry.weather)
        }
    }
}
