//
//  DailyQuotesTableViewController.swift
//  DailyReflection
//
//  Created by Jicell on 12/14/22.
//

import UIKit

class DailyQuotesTableViewController: UITableViewController {
    
    @IBOutlet weak var loadingQuotesActivityIndicator: UIActivityIndicatorView!
    
    var viewModel: DailyQuoteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DailyQuoteViewModel(delegate: self)
        viewModel.fetchDailyQuoteData()
        loadingQuotesActivityIndicator.startAnimating()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.tempQuoteArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return 150
        } else {
            return 100
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "currentQuote", for: indexPath) as? DailyQuoteTableViewCell else {return UITableViewCell()}
        
        let result = viewModel.tempQuoteArray[indexPath.row]
        cell.updateViews(quotes: result)
        loadingQuotesActivityIndicator.stopAnimating()
        loadingQuotesActivityIndicator.isHidden = true
        return cell
    }
}// end of class

extension DailyQuotesTableViewController: DailyQuoteViewModelDelegate {
    func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
