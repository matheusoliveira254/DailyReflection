//
//  DailyQuoteTableViewCell.swift
//  DailyReflection
//
//  Created by Jicell on 12/14/22.
//

import UIKit

class DailyQuoteTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var quoteTextView: UITextView!
    
    func updateViews() {
        authorLabel.text = "Jack Handey"
        dateLabel.text = "Dec 14,2022"
        quoteTextView.text = "Before you criticize someone, you should walk a mile in their shoes. That way when you criticize them, you are a mile away from them and you have their shoes."
    }
}
