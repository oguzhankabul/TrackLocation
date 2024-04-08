//
//  SplashScreenViewModel.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 6.04.2024.
//

import Foundation
import CoreLocation

protocol SplashScreenDataSource { }

protocol SplashScreenEventSource {
    func pushMapView()
}

protocol SplashScreenProtocol: SplashScreenDataSource, SplashScreenEventSource {}

final class SplashScreenViewModel: BaseViewModel<SplashScreenRouter>, SplashScreenProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.requestLocationAuthorization()
        LocationManager.shared.delegate = self
    }
    
    func pushMapView() {
        router.pushMapView()
    }
}

extension SplashScreenViewModel: LocationManagerDelegate {
    
    func didUpdateLocations(_ locations: [CLLocation]) { }
    
    func didChangeAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            LocationManager.shared.requestLocationAuthorization()
        case .restricted:
            router.pushWarningBottomSheet(warningMessage: "Kısıtlamaları kaldırarak uygulamayı kullanmaya devam edin.")
        case .denied:
            router.pushWarningBottomSheet(warningMessage: "Konum bilgisinin iznini vermeden uygulamayı kullanamazsınız.")
        case .authorizedAlways:
            router.pushMapView()
        case .authorizedWhenInUse:
            router.pushMapView()
        case .authorized:
            router.pushMapView()
        @unknown default:
            router.pushWarningBottomSheet(warningMessage: "Something Went Wrong!")
        }
    }
}
