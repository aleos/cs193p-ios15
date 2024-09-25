//
//  SetGame.swift
//  Set
//
//  Created by Alexander Ostrovsky on 22.07.2022.
//

import Foundation

struct SetGame {
    private(set) var deck: [Card] = {
        var cards = [Card]()
        Card.Number.allCases.forEach { number in
            Card.Shape.allCases.forEach { shape in
                Card.Shading.allCases.forEach { shading in
                    Card.Color.allCases.forEach { color in
                        cards.append(Card(number: number, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        return cards.shuffled()
    }()
    private(set) var cards: [Card] = []
    private(set) var score = 0
    
    var selectedCards: [Card] { cards.filter(\.isSelected) }
    var isSetSelected: Bool { selectedCards.count == 3 }
    var currentSetSelection: SetSelection {
        guard selectedCards.count == 3 else { return .incomplete }
        if selectedCards.isAllSameOrAllDifferent(\.number)
            && selectedCards.isAllSameOrAllDifferent(\.shape)
            && selectedCards.isAllSameOrAllDifferent(\.shading)
            && selectedCards.isAllSameOrAllDifferent(\.color)
        {
            return .matching
        } else {
            return .nonmatching
        }
    }
    
    init() {
        dealMoreCards()
    }
    
    mutating func choose(_ card: Card) {
        guard let selectedIndex = cards.firstIndex(where: { $0.id == card.id }) else { return }
        
        switch currentSetSelection {
        case .matching:
            let lastSelectedCards = selectedCards
            // When any card is touched on and there are already 3 matching Set cards selected
            if !cards[selectedIndex].isSelected {
                // if the touched card was not part of the matching Set, then select that card
                cards[selectedIndex].isSelected = true
            }
            cards = cards.filter { !lastSelectedCards.contains($0) }
        case .nonmatching:
            // When any card is touched and there are already 3 non-matching Set cards selected, deselect those 3 non-matching cards and select the touched-on card (whether or not it was part of the non-matching trio of cards).
            cards.indices.forEach { cards[$0].isSelected = false }
            cards[selectedIndex].isSelected = true
        case .incomplete:
            cards[selectedIndex].isSelected.toggle()
        }
        
        switch currentSetSelection {
        case .matching: incrementScore()
        case .nonmatching: decrementScore()
        case .incomplete: break
        }
        
        if cards.count < 12 {
            dealMoreCards()
        }
    }
    
    mutating func dealMoreCards() {
        guard !deck.isEmpty else { return }
        repeat {
            let moreCards = deck.suffix(3)
            cards.append(contentsOf: moreCards)
            deck = deck.dropLast(3)
        } while cards.count < 12
    }
    
    private mutating func incrementScore() {
        score += 1
    }
    
    private mutating func decrementScore() {
        score -= 1
    }
    
    struct Card: Hashable, Identifiable, Equatable {
        enum Number: CaseIterable { case one, two, three }
        enum Shape: CaseIterable { case diamond, squiggle, oval }
        enum Shading: CaseIterable { case solid, striped, open }
        enum Color: CaseIterable { case red, green, purple }

        let number: Number
        let shape: Shape
        let shading: Shading
        let color: Color
        
        var isSelected = false
                
        // Identifiable conformance
        let id = UUID()
    }
    
    enum SetSelection { case matching, nonmatching, incomplete }
}

extension Array where Element: Hashable {
    func isAllSame<T: Equatable>(_ by: KeyPath<Element, T>) -> Bool {
        dropFirst().allSatisfy({ $0[keyPath: by] == first?[keyPath: by] })
    }
    
    func isAllDifferent<T: Hashable>(_ by: KeyPath<Element, T>) -> Bool {
        Set(map({ $0[keyPath: by] })).count == count
    }
    
    func isAllSameOrAllDifferent<T: Hashable>(_ by: KeyPath<Element, T>) -> Bool {
        isAllSame(by) || isAllDifferent(by)
    }
}
