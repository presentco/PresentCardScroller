//
//  CardModel.swift
//  PresentCardScroller
//
//  Created by Patrick Niemeyer on 10/15/18.
//  Copyright © 2018 co.present. All rights reserved.
//

import Foundation
import UIKit

public class CardModel {
    public let image: UIImage
    public let title: String
    public let subtitle: String
    
    public init(image: UIImage, title: String, subtitle: String) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
}

extension CardModel: Equatable {
    public static func ==(lhs: CardModel, rhs: CardModel) -> Bool {
        return lhs.subtitle == rhs.subtitle
            && lhs.title == rhs.title
            && lhs.image == rhs.image
    }
}

