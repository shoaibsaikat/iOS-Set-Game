//
//  ViewController.swift
//  Set
//
//  Created by Mina Shoaib Rahman on 9/5/24.
//

import UIKit

class ViewController: UIViewController, SetCardParent {
    var cardDeck            = SetCardDeck()
    var matchedCount        = 0
    var animationRunning    = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardDeck.generateCards()
        initiateView()
    }
    
    func initiateView() {
        for index in 0 ..< 12 {
            let card = cardDeck.randomCard()
            cards[index].setCardView(parent: self, withShape: card.shape, withNumber: card.number, withColor: card.color, withBackground: card.shade)
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
        addThreeMoreCards()
    }
    
    private func addThreeMoreCards() {
        var emptyFound = false
        for _ in 0 ..< 3 {
            let card = cardDeck.randomCard()
            for cardView in cards {
                if !cardView.show {
                    emptyFound = true
                    cardView.setCardView(parent: self, withShape: card.shape, withNumber: card.number, withColor: card.color, withBackground: card.shade)
                    break
                }
            }
            if !emptyFound {
                cardDeck.putCardBack(card)
                break
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
            DispatchQueue.main.asyncAfter(deadline: .now() + SetCardView.transitionTime) {
                // Needed so that third card gets time to finish its animation
                self.numberOfCardsTapped = 0
                self.thirdCard = SetCard(shape: card.shape, number: card.number, color: card.textColor, shade: card.shade)
                if self.cardDeck.matchSet(first: self.firstCard!, second: self.secondCard!, third: self.thirdCard!) {
                    // matched
                    for card in self.cards {
                        if card.selected {
                            card.show       = false
                            card.selected   = false
                        }
                    }
                    self.matchedCount = self.matchedCount + 1
                    self.matchedSetLabel.text = "Set(\(self.matchedCount))"
                    DispatchQueue.main.asyncAfter(deadline: .now() + SetCardView.transitionTime) {
                        // Needed so that hide gets time to finish animation
                        self.addThreeMoreCards()
                    }
                } else {
                    // did not match
                    for card in self.cards {
                        if card.selected {
                            card.selected = false
                        }
                    }
                }
            }
        }
    }
    
    func animationStarted() {
        animationRunning = true
    }
    
    func animationFinished() {
        animationRunning = false
    }
    
    func getAnimationStatus() -> Bool {
        return animationRunning
    }
}

