//
//  BaseRouter.swift
//  TrackLocation
//
//  Created by Oğuzhan Kabul on 6.04.2024.
//

import UIKit

protocol Closable {
    func close(animated: Bool, completion: VoidClosure?)
    func popToRoot()
}

protocol RouterProtocol {
    
    associatedtype V: UIViewController
    var viewController: V? { get }
    
    func open(_ viewController: UIViewController, transition: Transition)
}

class Router: RouterProtocol, Closable {

    func popToRoot() {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        openTransition.popToRoot?(viewController)
    }
    
    
    weak var viewController: UIViewController?
    var openTransition: Transition?

    func open(_ viewController: UIViewController, transition: Transition) {
        transition.viewController = self.viewController
        transition.open(viewController)
    }
    
    func close(animated: Bool = true, completion: VoidClosure? = nil) {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        if let openModalTransition = openTransition as? ModalTransition {
            openModalTransition.isAnimated = animated
            openModalTransition.completionHandler = completion
        }
        
        if let openPushTransition = openTransition as? PushTransition {
            openPushTransition.isAnimated = animated
            openPushTransition.completionHandler = completion
        }
        
        openTransition.close(viewController)
    }
    
    deinit {
        debugPrint("deinit: \(self)")
    }
}
