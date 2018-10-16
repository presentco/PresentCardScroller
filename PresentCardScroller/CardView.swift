//
//  CardView.swift
//
//  Created by Patrick Niemeyer on 2/16/16.
//

import Foundation
import UIKit
import CoreGraphics
import Then
import TinyConstraints

public final class CardView : UIView
{
    // MARK: Static Properties
    private typealias Class = CardView

    public static let placeholderImage: UIImage = UIImage()
    public static let footerHeight: CGFloat = 74.0
    public static let separatorHeight: CGFloat = 1.0
    
    // MARK: Public Properties

    public weak var delegate : CardViewDelegate?

    public let backgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .white
        $0.clipsToBounds = true
    }

    public let dimmingView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0.06
        $0.isUserInteractionEnabled = false
    }

    public let footerView = CardViewFooterView()

    public let gradientView = GradientView()

    public let bottomSeparator = UIView()

    // MARK: Private Properties

    private let shadowYOffset: CGFloat = 2.0
    private let shadowRadius : CGFloat = 4.0

    // MARK: Initialization
    
    public required override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        // Temporary bounds
        self.bounds = CGRect(x:0, y:0, width: UIScreen.main.bounds.width , height: 300)

        backgroundImageView.do {
            addSubview($0)
            $0.edgesToSuperview(excluding: .bottom)
        }

        dimmingView.do {
            addSubview($0)
            $0.edgesToSuperview()
        }

        bottomSeparator.do {
            addSubview($0)
            $0.edgesToSuperview(excluding: .top)
            $0.height(Class.separatorHeight)
        }

        gradientView.do {
            addSubview($0)
            $0.bottomToTop(of: bottomSeparator)
            $0.widthToSuperview()
            $0.height(Class.footerHeight)
            
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.14
            $0.layer.shadowRadius = shadowRadius
            $0.layer.shadowOffset = CGSize(width: 0.0, height: shadowYOffset)
        }

        footerView.do {
            addSubview($0)
            $0.bottomToTop(of: bottomSeparator)
            $0.widthToSuperview()
            $0.height(Class.footerHeight)
        }

        backgroundImageView.bottomToTop(of: footerView)
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIView
    
    public override func layoutSubviews()
    {
        super.layoutSubviews()
        
        // Set a shadow path to improve performance.
        // Also remove the shadow from the top side of the footer view.
        let rect = CGRect(x:0, y:6, width: gradientView.bounds.width, height: gradientView.bounds.height-6)
        gradientView.layer.shadowPath = UIBezierPath(rect: rect).cgPath
    }
    
    // MARK: Public Methods
    
    public func apply(viewModel: ViewModel) {
        backgroundImageView.image = viewModel.backgroundImage
        
        footerView.titleLabel.text = viewModel.title
        footerView.subtitleLabel.text = viewModel.subtitle

        setNeedsLayout()
    }

    // MARK: CardView Theming
    
    func applyDefaultTheme()
    {
        footerView.titleLabel.font = .systemFont(ofSize: 18.0, weight: .semibold)
        footerView.titleLabel.numberOfLines = 1
        
        footerView.subtitleLabel.font = .systemFont(ofSize: 14.0, weight: .medium)
        footerView.subtitleLabel.numberOfLines = 1
        
        gradientView.colors = [.white, .white] // turned off
        bottomSeparator.backgroundColor = UIColor(hex: 0xEF_EF_F4)
        
        setNeedsLayout()
    }

    // MARK: View Model

    public struct ViewModel {
        public var backgroundImage: UIImage
        public var title: String
        public var subtitle: String
        
        public static func empty() -> ViewModel
        {
            return ViewModel(
                backgroundImage: CardView.placeholderImage,
                title: "",
                subtitle: ""
            )
        }

    }
}

// Add card functionality here
public protocol CardViewDelegate : class { }

// MARK: Footer View

/// The view comprising the title and subtitle at the bottom of the card
public final class CardViewFooterView : UIView
{
    // MARK: Properties

    public let titleLabel = UILabel()
    public let subtitleLabel = UILabel()

    // MARK: Initialization

    public required override init(frame: CGRect) {
        super.init(frame: frame)

        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)
        textStack.spacing = 4
        addSubview(textStack)
        textStack.widthToSuperview(offset: -18)
        textStack.centerInSuperview()
    }

    public convenience init() {
        self.init(frame: .zero)
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

