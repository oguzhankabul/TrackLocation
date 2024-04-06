//
//  BaseViewController.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 6.04.2024.
//

import UIKit
import Network

class BaseViewController<V: BaseViewModelProtocol>: UIViewController, UIGestureRecognizerDelegate {
    
    var viewModel: V
    
    init(viewModel: V) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func disableBackSwipe() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func enableBackSwipe() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    deinit {
        debugPrint("deinit: \(self)")
    }
    
    // MARK: - SetupViews
    func setupViews() {}
    
    // MARK: - SetupLayouts
    func setupLayouts() {}
}
