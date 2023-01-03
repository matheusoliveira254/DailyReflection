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
    
 let dateFormatter = DateFormatter()
    func updateViews(quotes: Quotes) {
        guard let dateConfigure = quotes.date.toDate() else {return}

        authorLabel.text = quotes.author
        dateLabel.text = dateConfigure.toString()
        quoteTextView.text = quotes.quote
    }
}
