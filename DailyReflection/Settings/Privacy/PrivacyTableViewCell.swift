//
//  PrivacyTableViewCell.swift
//  DailyReflection
//
//  Created by Jicell on 1/3/23.
//

import UIKit

class PrivacyTableViewCell: UITableViewCell {

    @IBOutlet weak var noteIconImage: UIImageView!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var chevronImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
