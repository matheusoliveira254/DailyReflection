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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
