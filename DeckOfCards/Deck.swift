//
//  Deck.swift
//  DeckOfCards
//
//  Created by Rama Milaneh on 11/9/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation

class Deck {
    
    var success: Bool!
    var deckID: String!
    var shuffled: Bool!
    var remaining: Int!
    var cards: [Card] = []
    let apiClient = CardAPIClient.shared
    
    func newDeck(completion: @escaping (Bool) -> Void) {
        apiClient.newDeckShuffled { (responseArray) in
            print(responseArray)
            self.success = responseArray["success"] as! Bool
            self.deckID = responseArray["deck_id"] as! String
            self.shuffled = responseArray["shuffled"] as! Bool
            self.remaining = responseArray["remaining"] as! Int
            completion(true)
            
        }
    }
    
    func drawCards(numberOfCards: Int,completion: @escaping (Bool, [Card]?) -> Void) {
        if numberOfCards <= self.remaining {
            apiClient.drawCards(numberOfCards: numberOfCards, deckId: self.deckID, with: { (resposeJson) in
            let cardsArray =  resposeJson["cards"] as! [[String:Any]]
            for card in cardsArray {
                let newCard = Card(dictionary: card)
                self.cards.append(newCard)
            }
            self.remaining = resposeJson["remaining"] as! Int
            completion(true, self.cards)
           })
        }
        
    }
    
    }
