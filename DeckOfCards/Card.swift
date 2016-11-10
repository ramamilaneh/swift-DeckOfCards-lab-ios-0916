//
//  Card.swift
//  DeckOfCards
//
//  Created by Rama Milaneh on 11/9/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation
import UIKit

class Card {
    
    let imageURLString: String
    let url: URL?
    let code: String
    var image: UIImage?
    let value: String
    let suit: String
    let apiClient = CardAPIClient.shared
    var isDownloading = false
    
    init(dictionary: [String:Any]) {
        
        
        self.value = dictionary["value"] as! String
        self.code = dictionary["code"] as! String
        self.suit = dictionary["suit"] as! String
        self.imageURLString = dictionary["image"] as? String ?? "n/a"
        self.url = URL(string: imageURLString)
    }
    
    func downloadImage(completion: @escaping (Bool) -> Void) {
        guard let unwrappedURL = self.url else { fatalError("Invalid URL") }
        apiClient.downloadImage(at: unwrappedURL) { (success, image) in
            self.image = image
            completion(success)
        }
    }
}
