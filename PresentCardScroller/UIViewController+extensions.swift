//
//  UIViewController+extensions.swift
//  PresentCardScroller
//
//  Dan Federman on 2/3/17.
//  Patrick Niemeyer
//

import Foundation
import UIKit

public extension UIViewController {
    
    /// Installs a child view controller into the specified subview of the receiver. For more information on installing child view controllers, [read this documentation](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/ImplementingaContainerViewController.html).
    /// - parameter viewController: The view controller to install.
    /// - parameter subview: The subview of the receiver in which to install the view controller. Can be the receiver's main view.
    /// - parameter layoutBlock: A block which sizes and optionally lays out the child view controller's view.
    /// - parameter childViewControllerView: The child view controller's view.
    public func installChild(viewController: UIViewController, in subview: UIView, layoutBlock: (_ childViewControllerView: UIView) -> Void = {_ in})
    {
        assert(subview == view || subview.isDescendant(of: view))
        
        addChild(viewController)
        subview.addSubview(viewController.view)
        layoutBlock(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    public func uninstallChild(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
}
