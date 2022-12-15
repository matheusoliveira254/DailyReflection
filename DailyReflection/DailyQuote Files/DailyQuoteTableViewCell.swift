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
    
    func updateViews(quote: String, date: String, author: String) {
        
        authorLabel.text = author
        dateLabel.text = date
        quoteTextView.text = quote
    }
}
