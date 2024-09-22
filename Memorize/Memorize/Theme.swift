//
//  Theme.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 22/9/2024.
//

import SwiftUICore

struct Theme {
    let name: String
    let icon: Image
    let emojis: [String]
    let numberOfPairsOfCards: Int?
    let foregroundColor: Color
    
    var shuffled: [String] {
        emojis[..<(numberOfPairsOfCards ?? emojis.count)].flatMap({ Array(repeating: $0, count: 2) }).shuffled()
    }
}

extension Theme: Identifiable {
    var id: String { name }
}

extension Theme {
    static let halloween = Theme(
        name: "Halloween",
        icon: Image(systemName: "moon.stars.fill"),
        emojis: ["👻", "🎃", "🕷️", "😈", "💀", "❄️", "🧙‍♂️", "🙀", "👹", "😱", "☠️", "🍭"],
        numberOfPairsOfCards: 5,
        foregroundColor: .purple
    )
    
    static let animals = Theme(
        name: "Animals",
        icon: Image(systemName: "dog.fill"),
        emojis: ["🐼", "🐔", "🦄", "🐶", "🐱", "🐭", "🐽", "🐍", "🐒"],
        numberOfPairsOfCards: nil,
        foregroundColor: .brown
    )
    
    static let sports = Theme(
        name: "Sports",
        icon: Image(systemName: "figure.basketball"),
        emojis: ["🏀", "🏈", "⚾", "🎱", "🥊", "🥋", "🎮", "🥎", "🏐"],
        numberOfPairsOfCards: nil,
        foregroundColor: .red
    )
    
    static let faces = Theme(
        name: "Faces",
        icon: Image(systemName: "face.smiling.inverse"),
        emojis: ["😀", "😢", "😉", "😂", "😊", "🤪", "😍", "🥳", "🤩"],
        numberOfPairsOfCards: 5,
        foregroundColor: .yellow
    )
    
    static let food = Theme(
        name: "Food",
        icon: Image(systemName: "carrot.fill"),
        emojis: ["🍏", "🍆", "🍒", "🍇", "🍓", "🫐", "🌽", "🥩", "🍕", "🍔", "🍗", "🍝", "🍣", "🍥", "🍨", "🍩", "🍪", "🍰", "🎂"],
        numberOfPairsOfCards: nil,
        foregroundColor: .orange
    )
    
    static let nature = Theme(
        name: "Nature",
        icon: Image(systemName: "tree.fill"),
        emojis: ["🌲", "🌿", "🍀", "🌱", "🌼", "🌸", "🌈", "☀️", "❄️", "🌊", "🌍"],
        numberOfPairsOfCards: nil,
        foregroundColor: .green
    )
    
    static let transport = Theme(
        name: "Transport",
        icon: Image(systemName: "car.fill"),
        emojis: ["🚗", "🚎", "🚓", "🚒", "🚑", "🚔", "🚖", "🚗", "🚛", "🚚", "🚝", "🚞", "🚟", "🚠", "🚡", "🚢", "🚣", "🚤"],
        numberOfPairsOfCards: 10,
        foregroundColor: .gray
    )
    
    static var random: Theme { themes.randomElement()! }
    
    private static let themes: [Theme] = [halloween, animals, sports, faces, food, nature, transport]
}
