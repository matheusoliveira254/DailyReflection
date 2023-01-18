//
//  NewEntryViewController.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/26/22.
//

import UIKit
import CoreLocation
import CoreImage

class EntryDetailViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var entryDescriptionTextView: UITextView!
    @IBOutlet weak var entryScoreSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dayScoreFaceOneImageView: UIImageView!
    @IBOutlet weak var dayScoreFaceTwoImageView: UIImageView!
    @IBOutlet weak var dayScoreFaceThreeImageView: UIImageView!
    @IBOutlet weak var dayScoreFaceFourImageView: UIImageView!
    @IBOutlet weak var dayScoreFaceFiveImageView: UIImageView!
    
    private let weatherService = WeatherService()
    private let locationService = LocationService()
    var viewModel: EntryDetailViewModel!
    var hideBarButton: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateViews()
        if entryDescriptionTextView.text == "Type Here..." {
            entryDescriptionTextView.textColor = UIColor.lightGray
        }
        entryDescriptionTextView.delegate = self
        DispatchQueue.main.async {
            self.invertImageColor(imageView: self.dayScoreFaceOneImageView)
            self.invertImageColor(imageView: self.dayScoreFaceTwoImageView)
            self.invertImageColor(imageView: self.dayScoreFaceThreeImageView)
            self.invertImageColor(imageView: self.dayScoreFaceFourImageView)
            self.invertImageColor(imageView: self.dayScoreFaceFiveImageView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationService.requestUpdatingLocation()
        locationService.authorizationCheck()
        if hideBarButton != false {
            self.navigationItem.rightBarButtonItem = nil
        }
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let newEntryTitle = entryTitleTextField.text,
              let newEntryDescription = entryDescriptionTextView.text else {return}
        let score = entryScoreSegmentedControl.selectedSegmentIndex + 1
        
        viewModel.saveEntry(title: newEntryTitle, dayScore: score, description: newEntryDescription)
        navigationController?.popViewController(animated: true)
    }
    
    func invertImageColor(imageView: UIImageView) {
        guard let image = imageView.image else {return}
        let context = CIContext()
        let currentFilter = CIFilter(name: "CIColorInvert")
        currentFilter?.setValue(CIImage(image: image), forKey: kCIInputImageKey)

        if let output = currentFilter?.outputImage,
           let cgimg = context.createCGImage(output, from: output.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            imageView.image = processedImage
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if entryDescriptionTextView.textColor == UIColor.lightGray {
            entryDescriptionTextView.text = nil
            entryDescriptionTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if entryDescriptionTextView.text.isEmpty {
            entryDescriptionTextView.text = "Type Here..."
            entryDescriptionTextView.textColor = UIColor.lightGray
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
