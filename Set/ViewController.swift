//
//  ViewController.swift
//  Set
//
//  Created by Mina Shoaib Rahman on 9/5/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        ▲ ● ■
    }
    @IBOutlet var cards: [SetCardView]! {
        didSet {
            for card in cards {
                let tap = UITapGestureRecognizer(target: card, action: #selector(card.cardTapped(gesture:)))
                card.addGestureRecognizer(tap)
            }
        }
    }
}

