//
//  NewEntryViewController.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/26/22.
//

import UIKit

class NewEntryViewController: UIViewController {
    
    @IBOutlet weak var newEntryTitleTextField: UITextField!
    @IBOutlet weak var newEntryDescriptionTextView: UITextView!
    @IBOutlet weak var newEntryScoreSegmentedControl: UISegmentedControl!
    
    var dayScore: String?
    let viewModel = NewEntryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func newEntrySaveButtonTapped(_ sender: UIBarButtonItem) {
        guard let newEntryTitle = newEntryTitleTextField.text,
              let newEntryDescription = newEntryDescriptionTextView.text,
              let score = dayScore else {return}
        
        viewModel.fetchWeather(location: <#T##String?#>)
        viewModel.createNewEntry(title: newEntryTitle, dayScore: newEntryDescription, description: score, weather: viewModel.weather?.icon ?? "c01d")
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
