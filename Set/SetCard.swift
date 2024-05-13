//
//  SetCard.swift
//  Set
//
//  Created by Mina Shoaib Rahman on 11/5/24.
//

import Foundation
import UIKit

struct SetCard {
    static var TypeCount = 3
    enum Shade {
        case Fill
        case Stripped
        case Blank
    }
    enum Shape: String {
        case Square     = "■"
        case Triangle   = "▲"
        case Circle     = "●"
    }
    var matched = false
    var shape: String
    var number: Int
    var color: UIColor
    var shade: SetCard.Shade
}
