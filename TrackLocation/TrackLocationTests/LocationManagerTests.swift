//
//  TrackLocationTests.swift
//  TrackLocationTests
//
//  Created by Oğuzhan Kabul on 6.04.2024.
//

import XCTest
@testable import TrackLocation
import CoreLocation

class LocationManagerTests: XCTestCase {
    var locationManager: LocationManager!
    
    override func setUp() {
        super.setUp()
        locationManager = LocationManager.shared
    }
    
    override func tearDown() {
        locationManager = nil
        super.tearDown()
    }
    
    func testStartTracking() {
        locationManager.startTracking()
        XCTAssertTrue(locationManager.isTracking)
    }
    
    func testStopTracking() {
        locationManager.startTracking()
        locationManager.stopTracking()
        XCTAssertFalse(locationManager.isTracking)
    }
    
    func testResetTracking() {
        locationManager.resetLocations()
        XCTAssertTrue(locationManager.getLocationList().isEmpty)
    }
}
