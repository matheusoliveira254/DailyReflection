//
//  NotificationsDetailViewController.swift
//  DailyReflection
//
//  Created by Jicell on 1/10/23.
//

import UIKit

class NotificationsDetailViewController: UIViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var allowNotificationsLabel: UILabel!
    @IBOutlet weak var quoteNotificationTimeLabel: UILabel!
    @IBOutlet weak var separatingView: UIView!
    @IBOutlet weak var entryNotificationsLabel: UILabel!
    @IBOutlet weak var toggleQuoteNotificationsSwitch: UISwitch!
    @IBOutlet weak var quoteDatePicker: UIDatePicker!
    @IBOutlet weak var toogleEntryNotificationsSwitch: UISwitch!
    @IBOutlet weak var entryDatePicker: UIDatePicker!
    
    // MARK: - Properties
    var date = Date()
    let notificationsNotAllowed = "notificationsNotAllowed"
    
    let quoteIdentifier = "quoteReminder"
    var quoteNotificationTime = "quoteNotificationTime"
    let quoteNotificationKey = "quoteNotificationNotAllowed"
    var notificationCenter = UNUserNotificationCenter.current()
    lazy var dailyQuoteContent: UNMutableNotificationContent = {
        let content = UNMutableNotificationContent()
        content.title = "Daily Quote"
        content.body = "Open the App to check out today's quote!"
        content.sound = .default
        content.userInfo = ["value": "Data with local notification"]
        
        return content
    }()
    
    let entryIdentifier = "entryReminder"
    var entryNotificationTime = "jornalNotificationTime"
    let entryNotificationKey = "entryNotificationNotAllowed"
    lazy var entryContent: UNMutableNotificationContent = {
        let newContent = UNMutableNotificationContent()
        newContent.title = "How did your day go?"
        newContent.body = "Don't forget to record today's memories."
        newContent.sound = .default
        newContent.userInfo = ["value": "Data with local notification"]
        
        return newContent
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let quoteNotificationTime = UserDefaults.standard.object(forKey: quoteNotificationTime) as? Data,
           let quoteTime = try? JSONDecoder().decode(DateComponents.self, from: quoteNotificationTime),
           let quoteDate = Calendar.current.date(from: quoteTime) {
            quoteDatePicker.date = quoteDate
        }
        
        if let journalNotificationTime = UserDefaults.standard.object(forKey: entryNotificationTime) as? Data,
           let journalTime = try? JSONDecoder().decode(DateComponents.self, from: journalNotificationTime),
           let journalDate = Calendar.current.date(from: journalTime) {
            entryDatePicker.date = journalDate
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSwitches()
    }
    
    @IBAction func quoteNotificationsToggle(_ sender: Any) {
        if toggleQuoteNotificationsSwitch.isOn == true {
            notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    self.notificationToggleTapped(dateSelector: self.quoteDatePicker, selectedTimeFor: self.quoteNotificationTime, notificationIdentifier: self.quoteIdentifier, notificationContent: self.dailyQuoteContent)
                    UserDefaults.standard.set(false, forKey: self.quoteNotificationKey)
                    print("Notification permission granted.")
                } else {
                    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                        DispatchQueue.main.async {
                            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                            self.toggleQuoteNotificationsSwitch.isOn = false
                        }
                    }
                    print("Notification permission denied currently, asking for permission on settings again.")
                }
            }
        } else {
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [self.quoteIdentifier])
            UserDefaults.standard.set(true, forKey: self.quoteNotificationKey)
            UserDefaults.standard.set(true, forKey: self.notificationsNotAllowed)
            print("Notification permission revoked.")
        }
    }
        
    @IBAction func entryNotificationsToggle(_ sender: Any) {
        if toogleEntryNotificationsSwitch.isOn {
            notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    self.notificationToggleTapped(dateSelector: self.entryDatePicker, selectedTimeFor: self.entryNotificationTime, notificationIdentifier: self.entryIdentifier, notificationContent: self.entryContent)
                    UserDefaults.standard.set(false, forKey: self.entryNotificationKey)
                    print("Notification permission granted.")
                } else {
                    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                        DispatchQueue.main.async {
                            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                            self.toogleEntryNotificationsSwitch.isOn = false
                        }
                    }
                    print("Notification permission denied currently, asking for permission on settings again.")
                }
            }
        } else {
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [self.entryIdentifier])
            UserDefaults.standard.set(true, forKey: self.entryNotificationKey)
            UserDefaults.standard.set(true, forKey: self.notificationsNotAllowed)
            print("Notification permission revoked.")
        }
    }
    
    @IBAction func quotePickerChange(_ sender: Any) {
        quoteNotificationsToggle((Any).self)
    }
    
    @IBAction func entryDatePickerChange(_ sender: Any) {
        entryNotificationsToggle((Any).self)
    }
    
    func notificationToggleTapped(dateSelector: UIDatePicker, selectedTimeFor: String, notificationIdentifier: String, notificationContent: UNMutableNotificationContent) {
        DispatchQueue.main.async {
            let fireDate = Calendar.current.dateComponents([.hour, .minute, .second], from: dateSelector.date.addingTimeInterval(0))
            UserDefaults.standard.set(fireDate.toData(), forKey: selectedTimeFor)
            if let notificationTime = UserDefaults.standard.object(forKey: selectedTimeFor) as? Data,
               let decodedTime = try? JSONDecoder().decode(DateComponents.self, from: notificationTime){
                let trigger = UNCalendarNotificationTrigger(dateMatching: decodedTime, repeats: true)
                let request = UNNotificationRequest(identifier: notificationIdentifier, content: notificationContent, trigger: trigger)
                self.notificationCenter.add(request) { (error) in
                    if error != nil {
                        print("Error = \(error?.localizedDescription ?? "error local notification")")
                    }
                }
            }
        }
    }
    
    func configureSwitches() {
        if UserDefaults.standard.bool(forKey: notificationsNotAllowed) == false {
            toggleQuoteNotificationsSwitch.isOn = true
            toogleEntryNotificationsSwitch.isOn = true
        } else {
            if UserDefaults.standard.bool(forKey: quoteNotificationKey) == false {
                toggleQuoteNotificationsSwitch.isOn = true
            } else {
                toggleQuoteNotificationsSwitch.isOn = false
            }
            
            if UserDefaults.standard.bool(forKey: entryNotificationKey) == false {
                toogleEntryNotificationsSwitch.isOn = true
            } else {
                toogleEntryNotificationsSwitch.isOn = false
            }
        }
    }
}// End of class.
