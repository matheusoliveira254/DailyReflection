//
//  AppDelegate.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/12/22.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    if granted {
                        if UserDefaults.standard.bool(forKey: "notificationsNotAllowed") != true {
                                UserDefaults.standard.set(false, forKey: "notificationsNotAllowed")
                        }
                        print("User gave permissions for local notifications")
                    } else {
                        UserDefaults.standard.set(true, forKey: "notificationsNotAllowed")
                        UserDefaults.standard.set(true, forKey: "quoteNotificationNotAllowed")
                        UserDefaults.standard.set(true, forKey: "entryNotificationNotAllowed")
                        print("User denied permissions for local notifications")
                    }
                }
        LocationService().authorizationCheck()
        return true
}

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

