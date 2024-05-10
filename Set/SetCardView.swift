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
        UIColor.systemGray3.setFill()
        UIColor.black.setStroke()
        card.fill()
    }

}
