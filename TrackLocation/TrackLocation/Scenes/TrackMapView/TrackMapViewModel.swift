//
//  TrackMapViewModel.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 7.04.2024.
//

import Foundation

protocol TrackMapViewDataSource {
    var locationList: [Location] { get }
    var isTracking: Bool { get }
}

protocol TrackMapViewEventSource {
    func resumeTracking()
    func startTracking()
    func resetTracking()
    func stopTracking()
    func pushWarningView()
}

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
    
    func pushWarningView() {
        router.pushWarningBottomSheet(warningMessage: "Konum bilgisinin iznini vermeden uygulamayı kullanamazsınız.")
    }
}
