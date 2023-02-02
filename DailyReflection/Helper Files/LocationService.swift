//
//  LocationViewModel.swift
//  DailyReflection
//
//  Created by Matheus Oliveira on 12/28/22.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    private let weatherService = WeatherService()
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var currentCity: String?
    var currentState: String? {
        didSet {
            guard let currentCity = currentCity,
                  let currentState = currentState else {return}
            weatherService.fetchWeather(currentCity: currentCity, currentState: currentState)
        }
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
    }

    func updateLocation(completion: @escaping () -> Void) {
        locationManager.startUpdatingLocation()
    }
    
    func requestUpdatingLocation() {
        if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted || locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
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
    
    func authorizationCheck() {
        if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways {
            print("User has AuthInUse, or AuthAlways")
            locationManager.startUpdatingLocation()
        } else if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted {
            print("User has Denied/restricted")
        } else if locationManager.authorizationStatus == .notDetermined {
            print("Not determined")
        }
    }
}//End of class
