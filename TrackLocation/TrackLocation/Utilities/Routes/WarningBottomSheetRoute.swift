//
//  WarningBottomSheetRoute.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 8.04.2024.
//

import Foundation

protocol WarningBottomSheetRoute {
    func pushWarningBottomSheet(warningMessage: String)
}

extension WarningBottomSheetRoute where Self: RouterProtocol {
    
    func pushWarningBottomSheet(warningMessage: String) {
        let router = WarningBottomSheetViewRouter()
        let vm = WarningBottomSheetViewModel(router: router, warningMessage: warningMessage)
        let vc = WarningBottomSheetViewController(viewModel: vm)
        let transition = ModalTransition()
        router.viewController = viewController
        router.openTransition = transition
        open(vc, transition: transition)
    }
}
