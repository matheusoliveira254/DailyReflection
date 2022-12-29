//
//  LocationViewModel.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/28/22.
//

import Foundation
import CoreLocation

class LocationViewModel: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var currentCity: String?
    var currentState: String?
    
    override init() {
      super.init()
      locationManager.delegate = self
    }

    func startUpdatingLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first else {return}
            
            if let city = placemark.locality, let state = placemark.administrativeArea {
                print("City: \(city), State: \(state)")
                self.currentCity = city
                self.currentState = state
            }
        }
        manager.stopUpdatingLocation()
    }
}
