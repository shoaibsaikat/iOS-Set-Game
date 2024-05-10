//
//  SetCardView.swift
//  Set
//
//  Created by Mina Shoaib Rahman on 10/5/24.
//

import UIKit

@IBDesignable
class SetCardView: UIView {
    override func draw(_ rect: CGRect) {
        let card = UIBezierPath(roundedRect: bounds, cornerRadius: 5.0)
        UIColor.systemGray5.setFill()
        UIColor.black.setStroke()
        card.fill()
        
        let font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.preferredFont(forTextStyle: .body).withSize(26.0))
        let cardLabel = NSAttributedString(string: "■", attributes: [.font: font, .foregroundColor: UIColor.red])
        let labelRect = bounds.insetBy(dx: bounds.width / 2 - cardLabel.size().width / 2, dy: bounds.height / 2 - cardLabel.size().height / 2)
        cardLabel.draw(in: labelRect)
    }

}
