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
    var text = "■"
    var textColor = UIColor.orange
    var fillColor = UIColor.systemGray5
    
    func setCard(withText text: String, withColor color: UIColor, withBackground bgColor: UIColor) {
        self.text = text
        self.textColor = color
        self.fillColor = bgColor
    }
    
    override func draw(_ rect: CGRect) {
        if show {
            let card = UIBezierPath(roundedRect: bounds, cornerRadius: 7.0)
            fillColor.setFill()
            card.fill()
            
            let font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.preferredFont(forTextStyle: .body).withSize(26.0))
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
