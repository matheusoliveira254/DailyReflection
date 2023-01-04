//
//  EditEntryViewController.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 1/4/23.
//

import UIKit

class EditEntryViewController: UIViewController {
    
    @IBOutlet weak var editEntryTitleTextField: UITextField!
    @IBOutlet weak var editEntryScoreSegmentedControl: UISegmentedControl!
    @IBOutlet weak var editEntryDescriptionTextView: UITextView!
    
    var viewModel: EditEntryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func editDayScoreValueChangedSegmentedControl(_ sender: UISegmentedControl) {
        switch editEntryScoreSegmentedControl.selectedSegmentIndex {
        case 0:
            viewModel.dayScoreEdited = "1"
        case 1:
            viewModel.dayScoreEdited = "2"
        case 2:
            viewModel.dayScoreEdited = "3"
        case 3:
            viewModel.dayScoreEdited = "4"
        case 4:
            viewModel.dayScoreEdited = "5"
        default:
            viewModel.dayScoreEdited = "5"
        }
    }
    
    @IBAction func saveEntryChangesButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    func populateViews() {
        guard let entry = viewModel.entryToBeEdited else {return}
        editEntryTitleTextField.text = entry.title
        editEntryScoreSegmentedControl.selectedSegmentIndex = entry.dayScore - 1
        editEntryDescriptionTextView.text = entry.description
    }
}

extension EditEntryViewController: EditEntryViewModelDelegate {
    func updateViews() {
        DispatchQueue.main.async {
            self.populateViews()
        }
    }
}
