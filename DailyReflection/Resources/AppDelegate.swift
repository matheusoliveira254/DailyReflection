//
//  AppDelegate.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/12/22.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate,  UNUserNotificationCenterDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    if granted {
                        print("User gave permissions for local notifications")
                    }
                }
        // Override point for customization after application launch.
//        NetworkController.fetchQod { result in
//            switch result {
//            case.success(let quoteOfDay):
//                print(quoteOfDay.quotes)
//
//            case.failure(let error):
//                print(error)
//            }
//        }
        

        print(URL.documentsDirectory)
        return true
    }
    
    func application(_ application: UIApplication, shouldSaveSecureApplicationState coder: NSCoder) -> Bool {
        coder.encode(11.0,forKey: "quotesInfo")
//        NetworkController.fetchWeatherInfo(location: "Salt Lake,UT") { result in
//            switch result {
//            case .success(let weather):
//                print("Today's weather is \(weather)")
//            case .failure(let error):
//                print(error)
//            }
//        }
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

