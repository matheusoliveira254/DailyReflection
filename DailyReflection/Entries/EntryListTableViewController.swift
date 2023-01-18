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
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadEntries()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadEntries()
        let locationServices = LocationService()
        locationServices.locationManager.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if indexOfGroup != nil {
            return viewModel.storage.groupedEntries[indexOfGroup!].count
        } else {
//            if viewModel.storage.entries.count <= 14 {
                return viewModel.storage.entries.count
//            } else {
//                return 14
//            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entriesCell", for: indexPath) as! EntryListTableViewCell
        let entry = viewModel.storage.entries[indexPath.row]
        indexOfGroup != nil ? cell.configure(entry: viewModel.storage.groupedEntries[indexOfGroup!][indexPath.row]) : cell.configure(entry: entry)
            
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexOfGroup == nil {
            if editingStyle == .delete {
                viewModel.deleteEntry(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
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
            let indexInt = index.row
            var entryToSend: Entry
            if indexOfGroup != nil {
                entryToSend = viewModel.storage.groupedEntries[indexOfGroup!][indexInt]
                destination.hideBarButton = true
            } else {
                entryToSend = viewModel.storage.entries[index.row]
            }
            destination.viewModel = EntryDetailViewModel(entry: entryToSend, entryIndex: indexInt)
        }
    }
}
