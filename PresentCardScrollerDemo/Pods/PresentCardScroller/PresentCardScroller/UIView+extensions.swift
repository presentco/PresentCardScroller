//
//  UIView+extensions.swift
//  PresentCardScroller
//
//  Created by Patrick Niemeyer on 10/15/18.
//  Copyright © 2018 co.present. All rights reserved.
//

import Foundation
import UIKit

public extension UIView
{
    public func layoutIfVisible() {
        setNeedsLayout()
        
        guard window != nil else {
            // We don't have a window, so we can't possibly be visible.
            return
        }
        
        layoutIfNeeded()
    }
    
    /// Sizes the receiver to be the same size as the superview.
    public func sizeToFitSuperview() {
        guard let superview = superview else {
            return
        }
        
        bounds = superview.bounds
        center = CGPoint(x: superview.bounds.midX, y: superview.bounds.midY)
    }
    
    public func sizeToFit(fixedWidth: CGFloat) {
        var desiredSize = sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        desiredSize.width = fixedWidth
        
        bounds.size = desiredSize
    }
    
}
