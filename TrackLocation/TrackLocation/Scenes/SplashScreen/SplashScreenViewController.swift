//
//  ViewController.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 6.04.2024.
//

import UIKit

final class SplashScreenViewController: BaseViewController<SplashScreenViewModel> {
    
    override func setupViews() {
        super.setupViews()
        view.backgroundColor = .red
        view.addSubviews()
    }
    
    override func setupLayouts() {
        super.setupLayouts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            self.viewModel.pushMapView()
        }
    }
}
