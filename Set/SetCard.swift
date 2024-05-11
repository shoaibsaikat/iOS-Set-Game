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
    
    static func matchSet(first: SetCard, second: SetCard, third: SetCard) -> Bool {
        if ((first.number == second.number && second.number == third.number) ||
            (first.number != second.number && second.number != third.number && third.number != first.number)) &&
            ((first.color == second.color && second.color == third.color) ||
            (first.color != second.color && second.color != third.color && third.color != first.color)) &&
            ((first.shape == second.shape && second.shape == third.shape) ||
            (first.shape != second.shape && second.shape != third.shape && third.shape != first.shape)) &&
            ((first.shade == second.shade && second.shade == third.shade) ||
            (first.shade != second.shade && second.shade != third.shade && third.shade != first.shade)) {
            return true
        }
        return false
    }
}
