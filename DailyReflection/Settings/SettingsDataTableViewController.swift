//
//  SettingsDataTableViewController.swift
//  DailyReflection
//
//  Created by Jicell on 1/3/23.
//

import UIKit

class SettingsDataTableViewController: UITableViewController {
    
    var isDarkModeOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        isDarkModeOn = UserDefaults.standard.bool(forKey: "isDarkModeOn")
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "termsAndConditionsCell", for: indexPath)
            return cell
        }
        
        if indexPath.row == 1 {
            let privacyCell = tableView.dequeueReusableCell(withIdentifier: "privacyCell", for: indexPath)
            return privacyCell
        }
        
        if indexPath.row == 2 {
            let darkModeCell = tableView.dequeueReusableCell(withIdentifier: "darkModeCell", for: indexPath) as! DarkModeTableViewCell
            
            if self.isDarkModeOn == true {
                darkModeCell.darkModeSwitch.isOn = true
            } else {
                darkModeCell.darkModeSwitch.isOn = false
            }
            return darkModeCell
        }
        
        if indexPath.row == 3 {
            let notificationsCell = tableView.dequeueReusableCell(withIdentifier: "notificationsCell", for: indexPath)
            return notificationsCell
        }
        return UITableViewCell()
    }
}
