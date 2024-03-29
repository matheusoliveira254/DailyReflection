//
//  EntryListTableViewController.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/14/22.
//

import UIKit
import CoreLocation

class EntryListTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    let viewModel = EntryListViewModel()
    var indexOfGroup: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadEntries()
        let locationServices = LocationService()
        locationServices.locationManager.delegate = self
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let statusBar = UIView(frame: scene.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = UIColor(named: "TabAndNavBarColor")
            scene.windows.first?.addSubview(statusBar)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.viewModel.loadEntries()
            self.viewModel.storage.groupEntries()
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if viewModel.storage.entries.count == 0 {
            return "To Get Started Press The + Button ↗"
        } else {
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if indexOfGroup != nil {
            return viewModel.storage.groupedEntries[indexOfGroup!].count
        } else {
            if viewModel.storage.entries.count <= 14 {
                return viewModel.storage.entries.count
            } else {
                return 14
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entriesCell", for: indexPath) as! EntryListTableViewCell
        let entry = viewModel.storage.entries[indexPath.row]
        if UserDefaults.standard.bool(forKey: "isDarkModeOn") == true {
            cell.weatherIconEntryListCellImageView.tintColor = UIColor.gray
            cell.moonIconEntryListImageView.tintColor = UIColor.gray
        } else {
            cell.weatherIconEntryListCellImageView.tintColor = UIColor.black
            cell.moonIconEntryListImageView.tintColor = UIColor.black
        }
        indexOfGroup != nil ? cell.configure(entry: viewModel.storage.groupedEntries[indexOfGroup!][indexPath.row]) : cell.configure(entry: entry)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexOfGroup != nil {
            return false
        } else {
            return true
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteEntry(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EntryDetailViewController else {return}
        if segue.identifier == "createNewEntry" {
            destination.viewModel = EntryDetailViewModel()
        } else if segue.identifier == "toEntryDetail" {
            guard let index = tableView.indexPathForSelectedRow else {return}
            var entryToSend: Entry
            if indexOfGroup != nil {
                entryToSend = viewModel.storage.groupedEntries[indexOfGroup!][index.row]
            } else {
                entryToSend = viewModel.storage.entries[index.row]
            }
            destination.viewModel = EntryDetailViewModel(entry: entryToSend)
        }
    }
}
