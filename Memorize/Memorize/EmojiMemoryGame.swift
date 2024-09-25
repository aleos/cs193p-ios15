//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 22/9/2024.
//

import SwiftUICore

class EmojiMemoryGame: ObservableObject {
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
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    var cardsColor: any ShapeStyle { theme.color }
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
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
