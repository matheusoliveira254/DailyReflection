//
//  DarkModeTableViewCell.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 1/18/23.
//

import UIKit

class DarkModeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var darkModeSwitch: UISwitch!

    @IBAction func darkModeSwitchSwiped(_ sender: UISwitch) {
            if sender.isOn {
                window?.overrideUserInterfaceStyle = .dark
                UserDefaults.standard.set(true, forKey: "isDarkModeOn")
                UserDefaults.standard.set(true, forKey: "UserOptedForDarkMode")
                UIApplication.shared.setAlternateIconName("AppIcon-2")
            } else {
                window?.overrideUserInterfaceStyle = .light
                UserDefaults.standard.set(false, forKey: "isDarkModeOn")
                UserDefaults.standard.set(false, forKey: "UserOptedForDarkMode")
                UIApplication.shared.setAlternateIconName(nil)
        }
    }
}
