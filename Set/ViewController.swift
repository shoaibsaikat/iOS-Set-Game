//
//  ViewController.swift
//  Set
//
//  Created by Mina Shoaib Rahman on 9/5/24.
//

import UIKit

class ViewController: UIViewController, SetCardParent {
    var setCards = [SetCard]()
    var randomCard: SetCard {
        return setCards.remove(at: Int.random(in: 0..<setCards.count))
    }
    var matchedCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateCards()
        initiateGame()
    }
    
    func generateCards() {
//        TODO: find a better way to enumerate shade and shape
        for number in 1...SetCard.TypeCount {
            for color in 1...SetCard.TypeCount {
                for shade in 1...SetCard.TypeCount {
                    for shape in 1...SetCard.TypeCount {
                        var cardColor: UIColor
                        switch color {
                        case 1: cardColor = UIColor.red
                        case 2: cardColor = UIColor.green
                        default: cardColor = UIColor.blue
                        }
                        var cardShade: SetCard.Shade
                        switch shade {
                        case 1: cardShade = SetCard.Shade.Fill
                        case 2: cardShade = SetCard.Shade.Stripped
                        default: cardShade = SetCard.Shade.Blank
                        }
                        var cardShape: String
                        switch shape {
                        case 1: cardShape = SetCard.Shape.Square.rawValue
                        case 2: cardShape = SetCard.Shape.Triangle.rawValue
                        default: cardShape = SetCard.Shape.Circle.rawValue
                        }
                        setCards.append(SetCard(shape: cardShape, number: number, color: cardColor, shade: cardShade))
                    }
                }
            }
        }
    }
    
    func initiateGame() {
        for index in 0..<12 {
            let card = randomCard
            cards[index].setCardView(withText: card.shape, number: card.number, withColor: card.color, withBackground: card.shade, parent: self)
        }
    }
    
    @IBOutlet weak var matchedSetLabel: UILabel!
    @IBOutlet var cards: [SetCardView]! {
        didSet {
            for card in cards {
                let tap = UITapGestureRecognizer(target: card, action: #selector(card.cardTapped(_:)))
                card.addGestureRecognizer(tap)
            }
        }
    }
    
    @IBAction func dealMoreCard(_ sender: UIButton) {
        for _ in 0..<3 {
            let card = randomCard
            for cardView in cards {
                if !cardView.show {
                    cardView.setCardView(withText: card.shape, number: card.number, withColor: card.color, withBackground: card.shade, parent: self)
                    break
                }
            }
        }
    }
    
    var numberOfCardsTapped = 0
    var firstCard, secondCard, thirdCard: SetCard?
    func cardTapped(_ card: SetCardView) {
        numberOfCardsTapped = numberOfCardsTapped + 1
        switch numberOfCardsTapped {
        case 1: firstCard = SetCard(shape: card.shape, number: card.number, color: card.textColor, shade: card.shade)
        case 2: secondCard = SetCard(shape: card.shape, number: card.number, color: card.textColor, shade: card.shade)
        default:
            numberOfCardsTapped = 0
            thirdCard = SetCard(shape: card.shape, number: card.number, color: card.textColor, shade: card.shade)
            if SetCard.matchSet(first: firstCard!, second: secondCard!, third: thirdCard!) {
                for card in cards {
                    if card.selected {
                        card.show = false
                        card.selected = false
                    }
                }
                matchedCount = matchedCount + 1
                matchedSetLabel.text = "Set(\(matchedCount)"
            } else {
                for card in cards {
                    if card.selected {
                        card.selected = false
                    }
                }
            }
        }
    }
}

