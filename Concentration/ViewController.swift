//
//  ViewController.swift
//  Concentration
//
//  Created by Victor on 4/8/18.
//  Copyright © 2018 zili.cs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game: Concentration!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var flipCount = 0 { didSet { flipCountLabel.text = "flips: \(flipCount)" } }
    var gameScore = 0 { didSet { scoreLabel.text = "scores: \(gameScore)" }}
    
    let gameThemes = [["🌍", "🎯", "🚀", "🐙", "💊", "👻", "🐊", "🍊"],
                     ["👩", "😷", "🐺", "💷", "🌛", "🚶", "🎱", "🚯"],
                     ["😺", "👩‍🎓", "🗽", "🌆", "🚣‍♀️", "🧛", "👟", "👞"],
                     ["💩", "🙉", "👾", "👩‍🚀", "😈", "💬", "🧙‍♀️", "🤹‍♂️"],
                     ["🔬", "👩‍🎤", "🤡", "💂", "🔯", "🧞", "🌲", "🧠"],
                     ["👽", "🤖", "🗽", "🧚‍♀️", "🏋", "💀", "🎒", "📠"]]
    
    lazy var emojiChoices: [String] = gameThemes[Int(arc4random_uniform(UInt32(gameThemes.count)))]
    var emoji = [Int: String]()
    @IBAction func startNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = gameThemes[Int(arc4random_uniform(UInt32(gameThemes.count)))]
        flipCount = 0
        gameScore = 0
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            flipCount = game.flipCount
            gameScore = game.gameScore
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let card = game.cards[index]
            let cardButton = cardButtons[index]
            if (card.isFaceUp) {
                cardButton.setTitle(emoji(for: card), for: UIControlState.normal)
                cardButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                cardButton.setTitle("", for: UIControlState.normal)
                cardButton.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5679532547, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5679532547, blue: 0, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

