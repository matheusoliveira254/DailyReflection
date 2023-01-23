//
//  NotificationsDetailViewController.swift
//  DailyReflection
//
//  Created by Jicell on 1/10/23.
//

import UIKit

class NotificationsDetailViewController: UIViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var AllowNotificationsLabel: UILabel!
    @IBOutlet weak var notificationTimeLabel: UILabel!
    @IBOutlet weak var separatingView: UIView!
    @IBOutlet weak var entryNotificationsLabel: UILabel!
    @IBOutlet weak var toggleNotificationsSwitch: UISwitch!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var toogleEntrySwitch: UISwitch!
    @IBOutlet weak var entryDatePicker: UIDatePicker!
    
    // MARK: - Properties
    var date = Date()
    var notificationTime = "quoteNotificationTime"
    var journalNotificationTime = "jornalNotification"
    var dailyQuoteCenter = UNUserNotificationCenter.current()
    lazy var dailyQuoteContent: UNMutableNotificationContent = {
        let content = UNMutableNotificationContent()
        content.title = "Daily Quote Notification"
        content.body = "This is a daily quote notification"
        content.sound = .default
        content.userInfo = ["value": "Data with local notification"]
        
        return content
    }()
    
    var journalCenter = UNUserNotificationCenter.current()
    lazy var journalNewContent: UNMutableNotificationContent = {
        let newContent = UNMutableNotificationContent()
        newContent.title = "Entry Notification"
        newContent.body = "Journal entry notification"
        newContent.sound = .default
        newContent.userInfo = ["value": "Data with local notification"]
        
        return newContent
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let notificationTime = UserDefaults.standard.object(forKey: notificationTime) as? Data,
           let time = try? JSONDecoder().decode(DateComponents.self, from: notificationTime),
           let date = Calendar.current.date(from: time) {
            myDatePicker.date = date
        }
        if let journalNotificationTime = UserDefaults.standard.object(forKey: journalNotificationTime) as? Data,
           let newTime = try? JSONDecoder().decode(DateComponents.self, from: journalNotificationTime),
           let newDate = Calendar.current.date(from: newTime) {
            entryDatePicker.date = newDate
        }
    }
    
    //  step 1 - hacer que la noficacion triggers cuando el user cambier la hora siempre y cuando el switch este encendido.
    // how do i activate the notification when the user changes the time if the switch is on
    
    @IBAction func allowNotificationsToggle(_ sender: Any) {
        if toggleNotificationsSwitch.isOn {
            
//            let center = UNUserNotificationCenter.current()
//            let content = UNMutableNotificationContent()
//
//            content.title = "Daily Quote Notification"
//            content.body = "This is a daily quote notification"
//            content.sound = .default
//            content.userInfo = ["value": "Data with local notification"]
            
            let fireDate = Calendar.current.dateComponents([.hour, .minute, .second], from: myDatePicker.date.addingTimeInterval(0))
            UserDefaults.standard.set(fireDate.toData(), forKey: notificationTime)
            if let notificationTime = UserDefaults.standard.object(forKey: notificationTime) as? Data,
               let time = try? JSONDecoder().decode(DateComponents.self, from: notificationTime){
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
                let request = UNNotificationRequest(identifier: "reminder", content: dailyQuoteContent, trigger: trigger)
                dailyQuoteCenter.add(request) { (error) in
                    if error != nil {
                        print("Error = \(error?.localizedDescription ?? "error local notification")")
                    }
                }
            }
        } else {
            toggleNotificationsSwitch
        }
    }
    
    @IBAction func entryNotificationsToggle(_ sender: Any) {
        
        
        if toogleEntrySwitch.isOn {
//            let newCenter = UNUserNotificationCenter.current()
//            let newContent = UNMutableNotificationContent()
//            newContent.title = "Entry Notification"
//            newContent.body = "Journal entry notification"
//            newContent.sound = .default
//            newContent.userInfo = ["value": "Data with local notification"]
            
            let newFireDate = Calendar.current.dateComponents([.hour, .minute, .second], from: entryDatePicker.date.addingTimeInterval(0))
            UserDefaults.standard.set(newFireDate.toData(), forKey: journalNotificationTime)
            if let journalNotificationTime = UserDefaults.standard.object(forKey: journalNotificationTime) as? Data,
               let newTime = try? JSONDecoder().decode(DateComponents.self, from: journalNotificationTime){
                let newTrigger = UNCalendarNotificationTrigger(dateMatching: newTime, repeats: true)
                let newRequest = UNNotificationRequest(identifier: "journalReminder", content: journalNewContent, trigger: newTrigger)
                journalCenter .add(newRequest) { (error) in
                    if error != nil {
                        print("Error = \(error?.localizedDescription ?? "error local notification")")
                    }
                }
            }
        }
    }
    
    @IBAction func datePickerChange(_ sender: Any) {
        
        allowNotificationsToggle( (Any).self)
        toggleNotificationsSwitch.isOn = true
    }
    
    @IBAction func entryDatePickerChange(_ sender: Any) {
        entryNotificationsToggle((Any).self)
        toogleEntrySwitch.isOn = true
        let newFireDate = Calendar.current.dateComponents([.hour, .minute, .second], from: entryDatePicker.date.addingTimeInterval(20))
        UserDefaults.standard.set(newFireDate.toData(), forKey: journalNotificationTime)

    }
}// End of class.


//  step 1 - hacer que la noficacion triggers cuando el user cambier la hora siempre y cuando el switch este encendido.
// step 2 - Set a time for the user to receive a notification every day on both notifications.
