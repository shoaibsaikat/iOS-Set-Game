//
//  SetCardView.swift
//  Set
//
//  Created by Mina Shoaib Rahman on 10/5/24.
//

import UIKit

@IBDesignable
class SetCardView: UIView {
    static let transitionTime       = 0.3
    static let transitionWaitTime   = SetCardView.transitionTime * 1.5
    static let scale: CGFloat       = 0.8
    static let fontSize: CGFloat    = 18.0
    static let cardRaidus: CGFloat  = 7.0
    weak var parent: SetCardParent?
    @IBInspectable var show = false {
        didSet {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: SetCardView.transitionTime, delay: 0, options: [], animations: {
                self.parent?.animationStarted()
                self.alpha = self.show ? 1 : 0
            }, completion: { _ in
                self.transform  = CGAffineTransform.identity
                self.parent?.animationFinished()
                if !self.show {
                    DispatchQueue.main.asyncAfter(deadline: .now() + SetCardView.transitionWaitTime) {
                        // Needed so that hide gets time to finish its animation
                        self.setNeedsDisplay()
                    }
                } else {
                    // TODO: any animation to show?
                    self.setNeedsDisplay()
                }
            })
        }
    }
    var selected = false {
        didSet {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: SetCardView.transitionTime, delay: 0, options: [], animations: {
                self.parent?.animationStarted()
                self.transform = self.selected ? CGAffineTransform.identity.scaledBy(x: SetCardView.scale, y: SetCardView.scale) : CGAffineTransform.identity
            }, completion: { _ in
                self.parent?.animationFinished()
            })
        }
    }
    @IBInspectable var shape           = "?"
    @IBInspectable var number          = 3
    @IBInspectable var textColor       = UIColor.red
    @IBInspectable var text            = ""
    var shade                          = SetCard.Shade.Blank
    
    func setCardView(parent: SetCardParent, withShape shape: String, withNumber number: Int, withColor color: UIColor, withBackground shading: SetCard.Shade) {
        self.shape      = shape
        self.number     = number
        self.textColor  = color
        self.shade      = shading
        self.show       = true
        self.parent     = parent
        self.text       = generateNumberedText(with: shape, amount: number)
    }
    
    func generateNumberedText(with shape: String, amount number: Int) -> String {
        var text = ""
        for _ in 0 ..< number {
            text = text + shape
        }
        return text
    }

    override func draw(_ rect: CGRect) {
        if show {
            let card = UIBezierPath(roundedRect: bounds, cornerRadius: SetCardView.cardRaidus)
            switch shade {
            case SetCard.Shade.Fill:
                UIColor.black.setFill()
                card.fill()
            case SetCard.Shade.Blank:
                UIColor.black.setStroke()
                card.stroke()
            default:
                UIColor.systemGray2.setFill()
                card.fill()
            }
            let font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.preferredFont(forTextStyle: .body).withSize(SetCardView.fontSize))
            let cardLabel = NSAttributedString(string: text, attributes: [.font: font, .foregroundColor: textColor])
            let labelRect = bounds.insetBy(dx: bounds.width / 2 - cardLabel.size().width / 2, dy: bounds.height / 2 - cardLabel.size().height / 2)
            cardLabel.draw(in: labelRect)
        }
    }

    @objc func cardTapped(_ gesture: UITapGestureRecognizer) {
        // tap won't work until the animation of one card is finished
        if let animationRunning = parent?.getAnimationStatus(), !animationRunning {
            switch gesture.state {
            case .ended:
                if !selected {
                    selected = true
                    parent?.cardTapped(self)
                }
            default: break
            }
        }
    }
}

protocol SetCardParent: NSObject {
    func cardTapped(_ card: SetCardView)
    func animationStarted()
    func animationFinished()
    func getAnimationStatus() -> Bool
}
