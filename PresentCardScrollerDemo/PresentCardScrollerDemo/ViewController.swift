//
//  ViewController.swift
//  PresentCardScroller
//
//  Created by Patrick Niemeyer on 10/15/18.
//  Copyright © 2018 co.present. All rights reserved.
//

import UIKit
import TinyConstraints
import PresentCardScroller

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cardScroller = CardScrollingViewController()
        installChild(viewController: cardScroller, in: view) {
            $0.edgesToSuperview(usingSafeArea: true)
            $0.backgroundColor = UIColor(hex: 0xDEDEDE)
        }
        cardScroller.delegate = self
        
        let models = (0...11).map { CardModel(
            image: UIImage(named: "photo\($0)").unsafelyUnwrapped,
            title: "This is card \($0)",
            subtitle: "(Image credit unsplash.com)")
        }
        DispatchQueue.main.asyncAfter(seconds: 1) {
            cardScroller.configure(with: models)
        }
    }
}

extension ViewController: CardScrollingViewControllerDelegate
{
    func cardScrolling(viewController: CardScrollingViewController, didSelectCardFor model: CardModel) {
        print("Selected: \(model.title)")
    }
    
    func cardScrollerScrollviewMoved() { }
    
    func cardScrollerUserFlippedCards(count: Int) { }
}
