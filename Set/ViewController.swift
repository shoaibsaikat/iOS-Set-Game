//
//  ViewController.swift
//  Set
//
//  Created by Mina Shoaib Rahman on 9/5/24.
//

import UIKit

class ViewController: UIViewController, SetCardParent {
    var cardDeck = SetCardDeck()
    var matchedCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardDeck.generateCards()
        initiateView()
    }
    
    func initiateView() {
        for index in 0..<12 {
            let card = cardDeck.randomCard()
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
            let card = cardDeck.randomCard()
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
            if cardDeck.matchSet(first: firstCard!, second: secondCard!, third: thirdCard!) {
                for card in cards {
                    if card.selected {
                        card.show = false
                        card.selected = false
                    }
                }
                matchedCount = matchedCount + 1
                matchedSetLabel.text = "Set(\(matchedCount))"
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

