//
//  TransitionHelper.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 6.04.2024.
//

import UIKit

@objc
protocol Transition: AnyObject {
    
    var viewController: UIViewController? { get set }

    func open(_ viewController: UIViewController)
    func close(_ viewController: UIViewController)
    @objc optional
    func popToRoot(_ viewController: UIViewController)
    @objc optional
    func setNavigationRoot(_ viewController: UIViewController)
    @objc optional
    func changeIndexOfTabBar(_ selectedIndex: Int)
}

protocol Animator: UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool { get set }
}
