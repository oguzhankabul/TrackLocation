//
//  MapViewRoute.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 7.04.2024.
//

import Foundation

protocol TrackMapViewRoute {
    func pushMapView()
}

extension TrackMapViewRoute where Self: RouterProtocol {
    
    func pushMapView() {
        let router = TrackMapViewRouter()
        let vm = TrackMapViewModel(router: router)
        let vc = TrackMapViewController(viewModel: vm)
        let transition = PlaceOnWindowTransition()
        let nav = BaseNavigationController(rootViewController: vc)
        open(nav, transition: transition)
    }
}
