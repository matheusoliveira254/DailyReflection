//
//  NewEntryViewController.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/26/22.
//

import UIKit
import CoreLocation

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var entryDescriptionTextView: UITextView!
    @IBOutlet weak var entryScoreSegmentedControl: UISegmentedControl!
    
    private let locationService = LocationService()
    var viewModel: EntryDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        populateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationService.startUpdatingLocation()
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let newEntryTitle = entryTitleTextField.text,
              let newEntryDescription = entryDescriptionTextView.text else {return}
        let score = entryScoreSegmentedControl.selectedSegmentIndex + 1
        
        if let entry = viewModel.entry {
            viewModel.updateEntry(entry: entry, newTitle: newEntryTitle, newDayScore: score, newDescription: newEntryDescription)
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            viewModel.fetchWeather(currentCity: locationService.currentCity ?? "New York", currentState: locationService.currentState ?? "NY") { result in
                if let result = result {
                    self.viewModel.createNewEntry(title: newEntryTitle, dayScore: score, description: newEntryDescription, weather: result)
                    DispatchQueue.main.async {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
        }
    }
    
    func populateViews() {
        guard let entry = viewModel.entry else {return}
        entryTitleTextField.text = entry.title
        entryScoreSegmentedControl.selectedSegmentIndex = entry.dayScore - 1
        entryDescriptionTextView.text = entry.description
    }
    
    @IBAction func entryScoreValueChangedSegmentedControl(_ sender: UISegmentedControl) {
        switch entryScoreSegmentedControl.selectedSegmentIndex {
        case 0:
            viewModel.dayScore = 1
        case 1:
            viewModel.dayScore = 2
        case 2:
            viewModel.dayScore = 3
        case 3:
            viewModel.dayScore = 4
        case 4:
            viewModel.dayScore = 5
        default:
            viewModel.dayScore = 5
        }
    }
}//End of class
