//
//  EntryListTableViewController.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/14/22.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    private let viewModel = EntryListViewModel()

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadEntries()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadEntries()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entriesCell", for: indexPath) as! EntryListTableViewCell
        let entry = viewModel.entries[indexPath.row]
        cell.configure(title: entry.title, date: "\(entry.date)", rating: "\(entry.dayScore)/5", weather: entry.weather)

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = viewModel.entries[indexPath.row]
            viewModel.deleteEntry(entryToBeDeleted: entry)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EntryDetailViewController else {return}
        if segue.identifier == "createNewEntry" {
            destination.viewModel = EntryDetailViewModel(entry: nil, entries: viewModel.entries)
        }
        
        if segue.identifier == "toEntryDetail" {
            guard let index = tableView.indexPathForSelectedRow else {return}
                let entryToSend = viewModel.entries[index.row]
            destination.viewModel = EntryDetailViewModel(entry: entryToSend, entries: viewModel.entries)
        }
    }
}
