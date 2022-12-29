//
//  NewEntryViewController.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/26/22.
//

import UIKit
import CoreLocation

class NewEntryViewController: UIViewController {
    
    @IBOutlet weak var newEntryTitleTextField: UITextField!
    @IBOutlet weak var newEntryDescriptionTextView: UITextView!
    @IBOutlet weak var newEntryScoreSegmentedControl: UISegmentedControl!
    
    var dayScore: String?
    let viewModel = NewEntryViewModel()
    let locationViewModel = LocationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationViewModel.startUpdatingLocation()
    }

    @IBAction func newEntrySaveButtonTapped(_ sender: UIBarButtonItem) {
        guard let newEntryTitle = newEntryTitleTextField.text,
              let newEntryDescription = newEntryDescriptionTextView.text,
              let score = dayScore else {return}
        
        viewModel.fetchWeather(currentCity: locationViewModel.currentCity ?? "New York", currentState: locationViewModel.currentState ?? "NY")
        viewModel.createNewEntry(title: newEntryTitle, dayScore: newEntryDescription, description: score, weather: viewModel.weather?.icon ?? "c01d")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func entryScoreValueChangedSegmentedControl(_ sender: UISegmentedControl) {
        switch newEntryScoreSegmentedControl.selectedSegmentIndex {
        case 0:
            dayScore = "1"
        case 1:
            dayScore = "2"
        case 2:
            dayScore = "3"
        case 3:
            dayScore = "4"
        case 4:
            dayScore = "5"
        default:
            dayScore = "5"
        }
    }
}//End of class
