//
//  WarningBottomSheetViewModel.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 8.04.2024.
//

import Foundation

protocol WarningBottomSheetViewDataSource {
    var warningMessage: String { get }
}

protocol WarningBottomSheetViewEventSource { }

protocol WarningBottomSheetViewProtocol: WarningBottomSheetViewDataSource, WarningBottomSheetViewEventSource { }

final class WarningBottomSheetViewModel: BaseViewModel<WarningBottomSheetViewRouter>, WarningBottomSheetViewProtocol {
    
    let warningMessage: String
    
    init(router: WarningBottomSheetViewRouter, warningMessage: String) {
        self.warningMessage = warningMessage
        super.init(router: router)
    }
}
