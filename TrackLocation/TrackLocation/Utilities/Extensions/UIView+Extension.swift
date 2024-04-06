//
//  UIView+Extension.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 7.04.2024.
//

import UIKit

public  extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
