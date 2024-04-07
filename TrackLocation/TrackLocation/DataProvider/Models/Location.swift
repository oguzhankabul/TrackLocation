//
//  Location.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 7.04.2024.
//

import CoreLocation

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    
    init(from location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
    }
    
    var clLocation: CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
}

