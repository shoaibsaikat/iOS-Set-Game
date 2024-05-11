//
//  SetCardView.swift
//  Set
//
//  Created by Mina Shoaib Rahman on 10/5/24.
//

import UIKit

@IBDesignable
class SetCardView: UIView {
    private var show = true
    var shape = "■"
    var number = 3
    var textColor = UIColor.red
    var shade = SetCard.Shade.Blank
    var text: String = ""
    
    func generateNumberedText(with shape: String, amount number: Int) -> String {
        var text = ""
        for _ in 0..<number {
            text = text + shape
        }
        return text
    }
    
    func setCard(withText shape: String, number: Int, withColor color: UIColor, withBackground shading: SetCard.Shade) {
        self.shape = shape
        self.number = number
        self.textColor = color
        self.shade = shading
        
        text = generateNumberedText(with: shape, amount: number)
    }
    
    override func draw(_ rect: CGRect) {
        if show {
//            TODO: remove after calling setCard done
            text = generateNumberedText(with: shape, amount: number)
            
            let card = UIBezierPath(roundedRect: bounds, cornerRadius: 7.0)
            switch shade {
            case SetCard.Shade.Fill:
                UIColor.systemGray.setFill()
                card.fill()
            case SetCard.Shade.Blank:
                UIColor.black.setStroke()
                card.stroke()
            default:
                UIColor.systemGray6.setFill()
                card.fill()
            }

            let font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.preferredFont(forTextStyle: .body).withSize(20.0))
            let cardLabel = NSAttributedString(string: text, attributes: [.font: font, .foregroundColor: textColor])
            let labelRect = bounds.insetBy(dx: bounds.width / 2 - cardLabel.size().width / 2, dy: bounds.height / 2 - cardLabel.size().height / 2)
            cardLabel.draw(in: labelRect)
        }
    }

    @objc func cardTapped(gesture: UITapGestureRecognizer) {
        show = false
        setNeedsDisplay()
    }
}
