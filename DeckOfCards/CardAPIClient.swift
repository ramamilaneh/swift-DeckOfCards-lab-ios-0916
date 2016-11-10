//
//  CardAPIClient.swift
//  DeckOfCards
//
//  Created by Rama Milaneh on 11/9/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation
import UIKit

struct CardAPIClient {
    
    static let shared = CardAPIClient()
    
    func newDeckShuffled (with completion: @escaping ([String:Any]) -> Void) {
        let urlString = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
        let url = URL(string: urlString)
        let session = URLSession.shared
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        let task = session.dataTask(with: unwrappedURL) { data, response, error in
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            
            if let responseArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                print(data)
                if let responseArray = responseArray {
                    completion(responseArray)
                }
            }
        }
        task.resume()
    }
    
    
    func drawCards(numberOfCards: Int, deckId: String, with completion: @escaping ([String:Any]) -> Void) {
        let urlString = "https://deckofcardsapi.com/api/deck/\(deckId)/draw/?count=\(numberOfCards)"
        let url = URL(string: urlString)
        let session = URLSession.shared
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        let task = session.dataTask(with: unwrappedURL) { data, response, error in
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            
            if let responseArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                if let responseArray = responseArray {
                    completion(responseArray)
                }
            }
        }
        task.resume()
    }
    
    func downloadImage(at url: URL, completion: @escaping (Bool, UIImage?) -> Void) {
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            let image = UIImage(data: data)
            completion(true, image)
        }
        task.resume()
    }
    
}


