//
//  TrackMapViewModelTest.swift
//  TrackLocationTests
//
//  Created by Oğuzhan Kabul on 8.04.2024.
//

import XCTest
@testable import TrackLocation

class TrackMapViewModelTests: XCTestCase {
    var viewModel: TrackMapViewModel!
    var mockRouter: TrackMapViewRouter!
    
    override func setUp() {
        super.setUp()
        mockRouter = TrackMapViewRouter()
        viewModel = TrackMapViewModel(router: mockRouter)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRouter = nil
        super.tearDown()
    }
    
    func testResumeTracking() {
        viewModel.resumeTracking()
        XCTAssertTrue(LocationManager.shared.isTracking)
    }
    
    func testStartTracking() {
        viewModel.startTracking()
        XCTAssertTrue(LocationManager.shared.isTracking)
    }
    
    func testStopTracking() {
        viewModel.startTracking()
        viewModel.stopTracking()
        XCTAssertFalse(LocationManager.shared.isTracking)
    }
    
    func testResetTracking() {
        viewModel.startTracking()
        viewModel.resetTracking()
        XCTAssertTrue(LocationManager.shared.getLocationList().isEmpty)
    }
}

