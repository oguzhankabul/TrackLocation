//
//  SplashScreenViewModel.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 6.04.2024.
//

import Foundation

protocol SplashScreenDataSource { }

protocol SplashScreenEventSource {
    func pushMapView()
}

protocol SplashScreenProtocol: SplashScreenDataSource, SplashScreenEventSource {}

final class SplashScreenViewModel: BaseViewModel<SplashScreenRouter>, SplashScreenProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func pushMapView() {
        router.pushMapView()
    }
}
