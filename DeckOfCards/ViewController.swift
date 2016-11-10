//
//  ViewController.swift
//  DeckOfCards
//
//  Created by Jim Campagno on 11/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var deck = Deck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deck.newDeck { (success) in
            print(success)
            print("New deck was created")
        }
        
        // TODO: Call newDeck on your deck instance property here.
        
    }
    
    @IBAction func drawCard(_ sender: Any) {
        self.deck.drawCards(numberOfCards: 1) { (successs, cards) in
            if successs {
                if let unwrappedCards = cards {
                    for card in unwrappedCards {
                        DispatchQueue.main.async {
                            self.newCardDealt(card)
                        }
                    
                    }
                }
            }else{
                print("There is no more cards")
            }
        }
        
        // TODO: Properly draw a card from the deck.
        
    }
    
    func newCardDealt(_ card: Card) {
        
        let viewHeight = view.frame.size.height
        let cardViewHeight = viewHeight * 0.2
        let percentage: CGFloat = 226 / 314
        let cardViewWidth = cardViewHeight * percentage
        
        let minX = 0 + (cardViewWidth / 2)
        let maxX = view.frame.size.width - (cardViewWidth)
        let minY = 0 + (cardViewHeight / 2)
        let maxY = view.frame.size.height - (cardViewHeight)
        
        let randomX = CGFloat(arc4random_uniform(UInt32(maxX - minX))) + minX
        let randomY = CGFloat(arc4random_uniform(UInt32(maxY - minY))) + minY
        
        let cardView = CardView(frame: CGRect(x: randomX, y: randomY, width: cardViewWidth, height: cardViewHeight))
        
        view.addSubview(cardView)
    
        cardView.card = card
    }
}
