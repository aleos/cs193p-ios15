//
//  SetGameViewModel.swift
//  Set
//
//  Created by Alexander Ostrovsky on 22.07.2022.
//

import SwiftUI

final class SetGameViewModel: ObservableObject {
    typealias Card = SetGame.Card
    
    @Published private var game = SetGame()
    
    var cards: [Card] { game.cards }
    var score: Int { game.score }
    
    var isSetSelected: Bool { game.isSetSelected }
    var currentSetSelection: SetGame.SetSelection { game.currentSetSelection }

    func choose(_ card: Card) {
        game.choose(card)
    }
    
    func dealMoreCards() {
        game.dealMoreCards()
    }
    
    func newGame() {
        game = SetGame()
    }
}
