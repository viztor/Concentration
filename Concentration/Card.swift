//
//  Card.swift
//  Concentration
//
//  Created by Victor on 4/9/18.
//  Copyright © 2018 zili.cs. All rights reserved.
//

import Foundation

struct Card {
    static var IdentifierFactory = 0
    static func GetUniqueIdentifier () -> Int {
        IdentifierFactory += 1
        return IdentifierFactory
    }
    
    var isFaceUp = false
    var isMatched = false
    var hasSeen = false
    var identifier: Int
    
    init() {
        identifier = Card.GetUniqueIdentifier()
    }
}
