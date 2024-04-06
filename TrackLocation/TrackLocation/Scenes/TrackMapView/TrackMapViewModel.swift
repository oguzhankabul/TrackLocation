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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
