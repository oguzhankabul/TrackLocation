//
//  TrackMapViewModel.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 7.04.2024.
//

import Foundation

protocol TrackMapViewDataSource { }

protocol TrackMapViewEventSource { }

protocol TrackMapViewProtocol: TrackMapViewDataSource, TrackMapViewEventSource {}

final class TrackMapViewModel: BaseViewModel<TrackMapViewRouter>, TrackMapViewProtocol {
    
    var locationList: [Location] {
        return LocationManager.shared.getLocationList()
    }
    
    var isTracking: Bool {
        return LocationManager.shared.isTracking
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func resumeTracking() {
        LocationManager.shared.resumeTracking()
    }
    
    func startTracking() {
        LocationManager.shared.startTracking()
    }
    
    func resetTracking() {
        LocationManager.shared.resetLocations()
    }
    
    func stopTracking() {
        LocationManager.shared.stopTracking()
    }
}
