//
//  DarkModeTableViewCell.swift
//  DailyReflection
//
//  Created by Jicell on 1/3/23.
//

import UIKit

class DarkModeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var moonImage: UIImageView!
    
    @IBOutlet weak var darkModeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func darkModeSwitch(_ sender: Any) {
    }
    
}
