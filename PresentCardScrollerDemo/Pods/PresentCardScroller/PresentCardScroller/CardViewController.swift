//
//  CardViewController.swift
//  Present
//
//  Created by Dan Federman on 2/3/17.
//  Created by Pat Niemeyer
//  Copyright © 2017 Present Company. All rights reserved.
//

import Foundation
import UIKit

/// CardViewController manages a single CardView within a CardScrollingViewController
public final class CardViewController: UIViewController, CardViewDelegate
{
    public var currentModel: CardModel?

    // The card view that we manage
    private var cardView: CardView?

    // The view model for our card view.
    private var cardViewModel: CardView.ViewModel? {
        didSet {
            // Update the card view
            if let currentViewModel = cardViewModel {
                cardView?.apply(viewModel: currentViewModel)
            }
        }
    }

    // Set the visibility status of the card. This will trigger building the card if it had not been shown.
    // Note: Set by the card scroller.
    public var isVisibleInCardScroller: Bool = false {
        didSet {
            guard oldValue != isVisibleInCardScroller else { return }
            updateCardView()
        }
    }

    // MARK: UIViewController
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        updateCardView()
    }
    
    public override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        guard let contentView = cardView else { return }
       
        let currentSnapshotSize = contentView.bounds.size
        let desiredSize = view.bounds.size
        contentView.sizeToFitSuperview()
        
        if currentSnapshotSize != .zero,
            currentSnapshotSize != desiredSize,
            currentModel != nil
        {
            // Make sure our snapshot is the right size.
            applyModel()
        }
    }
    
    // MARK: Private Methods

    // Update the current view model using the specified block. This triggers the card view to update.
    /// Capture the model associated with the request and attempt to atomically apply the view model changes
    /// only if still applicable (if this card hasn't been recycled?)
    private func updateViewModelWith(model: CardModel, withBlock update: @escaping (inout CardView.ViewModel) -> Void)
    {
        // The model associated with his view controller has changed since the async load completed.
        guard model == currentModel else { return }

        // The card has scrolled offscreen between the time the update was required and executed.
        guard isVisibleInCardScroller else { return }

        guard var viewModelToUpdate = self.cardViewModel else {
            //log("Card is visible in scrolling view controller, however no view model exists.")
            return
        }

        update(&viewModelToUpdate)

        self.cardViewModel = viewModelToUpdate
    }
    
    private func applyModel()
    {
        guard let model = currentModel else {
            return
        }

        // Init a new card view model if needed
        if cardViewModel == nil {
            cardViewModel = .empty()
        }

        // convenience to pass the model
        func updateViewModel(withBlock block: @escaping (inout CardView.ViewModel) -> Void) {
            updateViewModelWith(model: model, withBlock: block)
        }

        updateViewModel {
            $0.title = model.title
            $0.subtitle = model.subtitle
            $0.backgroundImage = model.image
        }
    }

    // If we are visible construct the card view and view model for the model
    // else remove the model and view from memory.
    private func updateCardView()
    {
        guard isViewLoaded else { return }

        if isVisibleInCardScroller
        {
            // Get the current card view or initialize one if needed.
            let cardViewToUpdate: CardView
            if let cardView = cardView {
                cardViewToUpdate = cardView
            } else {
                cardViewToUpdate = CardView()
                cardViewToUpdate.delegate = self
                cardView = cardViewToUpdate

                // Note: the theme doesn't change per card so we can do this once.
                cardViewToUpdate.applyDefaultTheme()
            }

            if currentModel != nil {
                applyModel()
            } else {
                cardViewModel = .empty()
            }
            
            if cardViewToUpdate.superview == nil {
                view.addSubview(cardViewToUpdate)
                view.layoutIfVisible()
            }
        } else
        {
            cardView?.removeFromSuperview()
            cardView = nil
            cardViewModel = nil
        }
    }

}


