//
//  SetCardView.swift
//  Set
//
//  Created by Mina Shoaib Rahman on 10/5/24.
//

import UIKit

@IBDesignable
class SetCardView: UIView {
    weak var parent: SetCardParent? = nil
    var show = false {
        didSet {
            setNeedsDisplay()
        }
    }
    var selected = false {
        didSet {
            if selected {
                self.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
            } else {
                self.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            }
            setNeedsDisplay()
        }
    }
    var shape = "■"
    var number = 3
    var textColor = UIColor.red
    var shade = SetCard.Shade.Blank
    var text: String = ""
    
    func setCardView(withText shape: String, number: Int, withColor color: UIColor, withBackground shading: SetCard.Shade, parent: SetCardParent) {
        self.shape = shape
        self.number = number
        self.textColor = color
        self.shade = shading
        self.show = true
        self.parent = parent
        text = generateNumberedText(with: shape, amount: number)
    }
    
    func generateNumberedText(with shape: String, amount number: Int) -> String {
        var text = ""
        for _ in 0..<number {
            text = text + shape
        }
        return text
    }

    override func draw(_ rect: CGRect) {
        if show {
            let card = UIBezierPath(roundedRect: bounds, cornerRadius: 7.0)
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

            let font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.preferredFont(forTextStyle: .body).withSize(20.0))
            let cardLabel = NSAttributedString(string: text, attributes: [.font: font, .foregroundColor: textColor])
            let labelRect = bounds.insetBy(dx: bounds.width / 2 - cardLabel.size().width / 2, dy: bounds.height / 2 - cardLabel.size().height / 2)
            cardLabel.draw(in: labelRect)
        }
    }

    @objc func cardTapped(_ gesture: UITapGestureRecognizer) {
        switch gesture.state {
        case .ended: selected = !selected
        default: break
        }
        parent?.cardTapped(self)
    }
}

protocol SetCardParent: NSObject {
    func cardTapped(_ card: SetCardView)
}
