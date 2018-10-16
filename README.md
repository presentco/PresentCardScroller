# PresentCardScroller

Pleasant Scrolling Cards UI in Swift

<table>
<tr>
<td><img src="Media/screens1.gif"></td>
<td></td>
</tr>
</table>

## Installation
### CocoaPods 

```pod 'PresentCardScroller', :git => 'https://github.com/presentco/PresentCardScroller.git'```
 
For more information see ([Cocoapods.org](https://cocoapods.org/))

## Usage
### Demo

Check out the demo project for a working example.

### Init and use a card scroller

Init the card scroller and add some models.

```swift
    let cardScroller = CardScrollingViewController()

    let models = [ 
      CardModel(
          image: UIImage(named: "photo").unsafelyUnwrapped,
          title: "This is a card",
          subtitle: "Image credit 'foo'"
      ),
      ...
    ]
    cardScroller.configure(with: models)
```

To be notified of selected cards implement the delegate

```swift
    cardScroller.delegate = self

    public protocol CardScrollingViewControllerDelegate: class {
      func cardScrolling(viewController: CardScrollingViewController, didSelectCardFor model: CardModel)
      ...
   }
```

### Some `PresentCardScroller` parameters to play with

```swift    
	/// If true cards are initially added with an animation
    public var animateCardDropIn = true
    
    /// If true a tap on a card will select the card regardless of position. If false
    /// only the top card is selectable and taps on other cards cause them to 
    /// auto-scroll to the top position.
    public var tapShowsCardAnyPosition = false
    
    /// If true cards scroll continuously with no adjustment to the stopping position.
    /// If false card scrolling will "settle" with a card aligned at the top of the view.
    public var cardsScrollContinuous = false
    
    /// The rolloff easing function exponent: y = x^power * const
    public var rolloffPower: CGFloat = 4 
    
    /// The rolloff easing function constant: y = x^power * const
    public var rolloffConstant: CGFloat = 3.0
    
    /// If `true`, the card alpha fades to zero as it leaves the screen.
    public let transformAlpha = false
````


