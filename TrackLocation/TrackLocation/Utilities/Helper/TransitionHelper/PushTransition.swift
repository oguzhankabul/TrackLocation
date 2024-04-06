//
//  PushTransition.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 6.04.2024.
//

import UIKit

class PushTransition: NSObject {
    
    var animator: Animator?
    var isAnimated: Bool = true
    var completionHandler: VoidClosure?
    weak var viewController: UIViewController?
    
    init(animator: Animator? = nil, isAnimated: Bool = true) {
        self.animator = animator
        self.isAnimated = isAnimated
    }
}

// MARK: - Transition
extension PushTransition: Transition {
    
    func open(_ viewController: UIViewController) {
        self.viewController?.navigationController?.delegate = self
        self.viewController?.navigationController?.pushViewController(viewController, animated: isAnimated)
    }
    
    func close(_ viewController: UIViewController) {
        self.viewController?.navigationController?.popViewController(animated: isAnimated)
    }
    
    func popToRoot(_ viewController: UIViewController) {
        self.viewController?.navigationController?.popToRootViewController(animated: isAnimated)
    }
    
    func setNavigationRoot(_ viewController: UIViewController) {
        self.viewController?.navigationController?.setViewControllers([viewController], animated: true)
    }
}

// MARK: - UINavigationControllerDelegate
extension PushTransition: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        completionHandler?()
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        if operation == .push {
            animator.isPresenting = true
            return animator
        } else {
            animator.isPresenting = false
            return animator
        }
    }
}

