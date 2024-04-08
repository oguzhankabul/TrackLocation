//
//  WarningBottomSheetViewController.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 8.04.2024.
//

import UIKit
import MapKit

final class WarningBottomSheetViewController: BaseViewController<WarningBottomSheetViewModel> {
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [messageLabel, closeButton])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 40
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = viewModel.warningMessage
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubviews(containerStackView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        NSLayoutConstraint.activate([
            containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            containerStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
    
    @objc private func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
