//
//  ClearView.swift
//  Present

import CoreGraphics
import UIKit

/// A view that does not intercept touches (other than via its child views).
/// This supports having a transparent background that passes touches up the view hierarchy.
public class ClearView : UIView
{
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hit = super.hitTest(point, with: event)
        return hit == self ? nil : hit
    }
}
