//
//  Concentration.swift
//  Concentration
//
//  Created by Victor on 4/9/18.
//  Copyright © 2018 zili.cs. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var gameScore = 0
    var flipCount = 0
    
    func chooseCard (at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIdnex = indexOfOneAndOnlyFaceUpCard, matchIdnex != index {
                if (cards[matchIdnex].identifier == cards[index].identifier) {
                    cards[matchIdnex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 2
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                if cards[index].hasSeen {
                    gameScore -= 1
                } else {
                    cards[index].hasSeen = true
                }
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards
        {
            let card = Card()
            cards.insert(card, at: Int(arc4random_uniform(UInt32(cards.count))))
            cards.insert(card, at: Int(arc4random_uniform(UInt32(cards.count))))
        }
    }
}
