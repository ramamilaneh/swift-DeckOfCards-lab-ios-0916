//
//  CardView.swift
//  DeckOfCards
//
//  Created by Jim Campagno on 11/4/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit



class CardView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    weak var card: Card! {
        didSet {
            updateViewToReflectNewCard()
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.constrainEdges(to: self)
        backgroundColor = UIColor.clear
        setupGestureRecognizer()
    }
    
    
    
}


// MARK: - Card Methods
extension CardView {
    
    fileprivate func updateViewToReflectNewCard() {
        
        // TODO: Update the view accordingly
        if card.image == nil {
            card.downloadImage(completion: { (success) in
                DispatchQueue.main.async {
                    self.imageView.image = self.card.image
                    print(success)
                }
                
            })
        }else{
            print("there is no more cards")
        }
        
    }
    
}


// MARK: - Pan Gestures
extension CardView {
    
    func setupGestureRecognizer() {
        
        // TODO: Setup Pan Gesture Recognizer
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(viewMoved(_:)))
        self.addGestureRecognizer(gesture)
        
        
        
    }
    
    func viewMoved(_ gesture: UIPanGestureRecognizer) {
        
        // TODO: Update self.center to reflect the new center
        let translation = gesture.translation(in: contentView)
        if let view = gesture.view {
            view.center = CGPoint(x: view.center.x + translation.x,
                                  y: view.center.y + translation.y)
        }
        gesture.setTranslation(CGPoint.zero, in: contentView)
    }
    
}






// MARK: - UIView Extension
extension UIView {
    
    func constrainEdges(to view: UIView) {
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}
