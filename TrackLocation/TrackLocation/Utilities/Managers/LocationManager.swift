//
//  LocationManager.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 7.04.2024.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocations(_ locations: [CLLocation])
    func didChangeAuthorization(status: CLAuthorizationStatus)
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    
    var isTracking: Bool {
            get { UserDefaults.standard.bool(forKey: "isTracking") }
            set { UserDefaults.standard.set(newValue, forKey: "isTracking") }
        }
    
    var locations: [Location] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "locations"),
                  let locations = try? JSONDecoder().decode([Location].self, from: data) else {
                return []
            }
            return locations
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: "locations")
        }
    }

    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocationAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }

    func startTracking() {
        isTracking = true
        locationManager.distanceFilter = 100
        locationManager.startUpdatingLocation()
        
        if let currentLocation = locationManager.location {
            let newLocationModel = Location(from: currentLocation)
            self.locations.append(newLocationModel)
            delegate?.didUpdateLocations([currentLocation])
        }
    }

    func stopTracking() {
        isTracking = false
        locationManager.stopUpdatingLocation()
    }
    
    func resumeTracking() {
        isTracking = true
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations clLocations: [CLLocation]) {
        guard let newLocation = clLocations.last, isTracking else { return }

        if locations.isEmpty || (locations.last?.clLocation.distance(from: newLocation) ?? 0) >= 100 {
            let newLocationModel = Location(from: newLocation)
            self.locations.append(newLocationModel)
            delegate?.didUpdateLocations([newLocation])
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        delegate?.didChangeAuthorization(status: status)
    }
    
    func resetLocations() {
        locations = []
        UserDefaults.standard.removeObject(forKey: "locations")
    }
}
