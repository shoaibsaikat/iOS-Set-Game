//
//  SetCard.swift
//  Set
//
//  Created by Mina Shoaib Rahman on 11/5/24.
//

import Foundation
import UIKit

struct SetCard {
    enum Shading {
        case Fill
        case Stripped
        case Blank
    }
    var matched = false
    var text: String
    var number: Int
    var color: UIColor
    var shading: SetCard.Shading
}
