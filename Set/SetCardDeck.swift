//
//  SetCardDeck.swift
//  Set
//
//  Created by Mina Shoaib Rahman on 13/5/24.
//

import Foundation
import UIKit

struct SetCardDeck {
    private var setCards = [SetCard]()

    mutating func randomCard() -> SetCard {
        return setCards.remove(at: Int.random(in: 0 ..< setCards.count))
    }

    mutating func generateCards() {
        // TODO: find a better way to enumerate shade and shape
        for number in 1 ... SetCard.TypeCount {
            for color in 1 ... SetCard.TypeCount {
                for shade in 1 ... SetCard.TypeCount {
                    for shape in 1 ... SetCard.TypeCount {
                        var cardColor: UIColor
                        switch color {
                        case 1:     cardColor = UIColor.red
                        case 2:     cardColor = UIColor.green
                        default:    cardColor = UIColor.blue
                        }
                        var cardShade: SetCard.Shade
                        switch shade {
                        case 1:     cardShade = SetCard.Shade.Fill
                        case 2:     cardShade = SetCard.Shade.Stripped
                        default:    cardShade = SetCard.Shade.Blank
                        }
                        var cardShape: String
                        switch shape {
                        case 1:     cardShape = SetCard.Shape.Square.rawValue
                        case 2:     cardShape = SetCard.Shape.Triangle.rawValue
                        default:    cardShape = SetCard.Shape.Circle.rawValue
                        }
                        setCards.append(SetCard(shape: cardShape, number: number, color: cardColor, shade: cardShade))
                    }
                }
            }
        }
    }
    
    mutating func putCardBack(_ card: SetCard) {
        setCards.append(card)
    }
    
    mutating func matchSet(first: SetCard, second: SetCard, third: SetCard) -> Bool {
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
