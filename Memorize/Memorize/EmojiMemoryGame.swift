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
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model: MemoryGame<String>
    private var theme: Theme
    
    init() {
        theme = Theme.random
        model = Self.createMemoryGame(theme: theme)
    }
    
    var themeName: String { theme.name }
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    var cardsColor: Color { theme.color }
    var score: Int { model.score }
    
    // MARK: - Intents
    
    func newGame() {
        theme = Theme.random
        model = Self.createMemoryGame(theme: theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
