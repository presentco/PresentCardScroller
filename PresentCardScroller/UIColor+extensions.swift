//
//  UIColor+extensions.swift
//  PresentCardScroller
//
//  Created by Patrick Niemeyer on 10/15/18.
//

import Foundation
import UIKit

public extension UIColor
{
    @nonobjc
    public convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    /// Take an RGB encoded Int value, e.g. 0xAA_BB_CC
    public convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = hex >> 16
        let g = (hex >> 8) & 0xff
        let b = hex & 0xff
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
