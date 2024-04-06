//
//  AppRoute.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 6.04.2024.
//

import UIKit

final class AppRoute {
    
    var window: UIWindow?
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let router = SplashScreenRouter()
        let vm = SplashScreenViewModel(router: router)
        let vc = SplashScreenViewController(viewModel: vm)
        router.viewController = vc
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
}

let app = AppContainer()

final class AppContainer {
    let route = AppRoute()
}
