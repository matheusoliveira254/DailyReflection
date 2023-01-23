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
        authorLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium, width: .condensed)
        authorLabel.text = quotes.author
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium, width: .condensed)
        dateLabel.text = dateConfigure.toString()
        quoteTextView.text = quotes.quote
    }
}
