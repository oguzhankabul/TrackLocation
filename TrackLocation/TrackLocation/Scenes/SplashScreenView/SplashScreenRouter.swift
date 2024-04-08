//
//  SplashScreenRouter.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 6.04.2024.
//

import Foundation

final class SplashScreenRouter: Router, SplashScreenRouter.Routes {
    typealias Routes = TrackMapViewRoute & WarningBottomSheetRoute
}
