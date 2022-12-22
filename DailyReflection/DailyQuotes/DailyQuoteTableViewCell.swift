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
    
    func updateViews(quotes: Quotes) {
        
        authorLabel.text = quotes.author
//        dateLabel.text =
        quoteTextView.text = quotes.quote
    }
}
