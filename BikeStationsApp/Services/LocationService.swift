//
//  LocationService.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 10/05/2024.
//

import Foundation
import CoreLocation


import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocation)
    func didFailWithError(_ error: Error)
}

class LocationService: NSObject {
    
    weak var delegate: LocationServiceDelegate?
    
    var location: CLLocation? {
        locationManager.location
    }
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
            
        case .restricted, .denied:
            let error = NSError(domain: "LocationService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Location access is denied."])
            
            delegate?.didFailWithError(error)
            
        case .notDetermined:
            break
            
        @unknown default:
            fatalError("Unknown location authorization status.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        delegate?.didUpdateLocation(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFailWithError(error)
    }
}
