//
//  TrackMapViewController.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 7.04.2024.
//

import UIKit

final class TrackMapViewController: BaseViewController<TrackMapViewModel> {
    
    override func setupViews() {
        super.setupViews()
        view.backgroundColor = .systemBlue
        view.addSubviews()
    }
    
    override func setupLayouts() {
        super.setupLayouts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}
