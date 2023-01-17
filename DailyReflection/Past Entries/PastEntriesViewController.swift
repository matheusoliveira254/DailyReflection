//
//  PastEntriesViewController.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 1/11/23.
//

import UIKit

class PastEntriesViewController: UIViewController {
    
    @IBOutlet weak var pastEntriesCollectionView: UICollectionView!
    
    var viewModel: PastEntriesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PastEntriesViewModel()
        pastEntriesCollectionView.dataSource = self
        pastEntriesCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pastEntriesCollectionView.reloadData()
    }

//    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "toPastEntriesListVC",
//              let cell = sender as? PastEntriesCollectionViewCell,
//              let indexPath = pastEntriesCollectionView.indexPath(for: cell),
//              let destinationVC = segue.destination as? EntryListTableViewController else {return}
//        destinationVC.viewModel.entriesGroupReceived = viewModel.storage.groupedEntries[indexPath.row]
//    }
}//End of class

extension PastEntriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.storage.groupedEntries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pastEntriesCell", for: indexPath) as! PastEntriesCollectionViewCell
        let entriesGroup = viewModel.storage.groupedEntries[indexPath.row]
        cell.configure(entryArray: entriesGroup)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Entries", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "Entries") as? EntryListTableViewController else {return}
        vc.indexOfGroup = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}
