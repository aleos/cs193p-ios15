//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 22/9/2024.
//

import SwiftUICore

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let numberOfPairs = min(theme.emojis.count, theme.numberOfPairs ?? Int.random(in: 2..<emojis.count))
        return MemoryGame(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            emojis.indices.contains(pairIndex) ? emojis[pairIndex] : "⁉️"
        }
    }
    
    @Published private var model: MemoryGame<String>
    private var theme: Theme
    
    init() {
        theme = Theme.random
        model = Self.createMemoryGame(theme: theme)
        model.shuffle()
    }
    
    var themeName: String { theme.name }
    var cards: Array<Card> { model.cards }
    var cardsColor: ThemeColorStyle { theme.colorStyle }
    var score: Int { model.score }
    
    // MARK: - Intents
    
    func newGame() {
        theme = Theme.random
        model = Self.createMemoryGame(theme: theme)
        model.shuffle()
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
