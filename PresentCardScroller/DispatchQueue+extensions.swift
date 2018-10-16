//
//  DispatchQueue+extensions.swift
//  PresentCardScroller
//
//  Created by Patrick Niemeyer on 10/16/18.
//

import Foundation

extension DispatchQueue {
    
    public func asyncAfter(seconds: Int, execute work: @escaping @convention(block) () -> Swift.Void) {
        self.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(seconds), execute: work)
    }
}
