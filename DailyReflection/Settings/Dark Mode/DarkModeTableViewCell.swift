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
        switchThemeColor(isOn: sender.isOn)
    }
    
    func switchThemeColor(isOn: Bool) {
        window?.overrideUserInterfaceStyle = isOn ? .dark : .light
        UserDefaults.standard.set(isOn ? true : false, forKey: "isDarkModeOn")
        UserDefaults.standard.set(isOn ? true : false, forKey: "UserOptedForDarkMode")
        UIApplication.shared.setAlternateIconName(isOn ? "AppIcon-2" : nil)
    }
}
