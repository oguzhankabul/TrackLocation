//
//  BaseNavigationController.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 7.04.2024.
//

import UIKit

class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        debugPrint("deinit: \(self)")
    }
}
