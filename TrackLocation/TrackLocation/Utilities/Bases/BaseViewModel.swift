//
//  BaseViewModel.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 6.04.2024.
//

import Foundation

protocol BaseViewModelProtocol {
    
    func viewDidLoad()
}

class BaseViewModel<R: Router>: BaseViewModelProtocol {

    let router: R
    
    init(router: R) {
        self.router = router
    }
    
    func viewDidLoad() {}

    deinit {
        debugPrint("deinit \(self)")
    }
}
