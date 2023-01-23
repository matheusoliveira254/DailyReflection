//
//  NotificationsTableViewCell.swift
//  DailyReflection
//
//  Created by Jicell on 1/10/23.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var clockIconImage: UIImageView!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var chevronIconImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
