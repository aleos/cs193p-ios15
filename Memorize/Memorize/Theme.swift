//
//  Theme.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 22/9/2024.
//

import SwiftUICore

struct Theme {
    let name: String
    let emojis: [String]
    let numberOfPairs: Int
    let color: Color
}

extension Theme: Identifiable {
    var id: String { name }
}

extension Theme {
    static let halloween = Theme(
        name: "Halloween",
        emojis: ["👻", "🎃", "🕷️", "😈", "💀", "❄️", "🧙‍♂️", "🙀", "👹", "😱", "☠️", "🍂", "⚰️", "🪦"],
        numberOfPairs: 13,
        color: .purple
    )
    
    static let animals = Theme(
        name: "Animals",
        emojis: ["🐼", "🐔", "🦄", "🐶", "🐱", "🐭", "🐽", "🐍", "🐒"],
        numberOfPairs: 9,
        color: .brown
    )
    
    static let sports = Theme(
        name: "Sports",
        emojis: ["🏀", "🏈", "⚾", "🎱", "🥊", "🥋", "🎮", "🥎", "🏐"],
        numberOfPairs: 8,
        color: .red
    )
    
    static let faces = Theme(
        name: "Faces",
        emojis: ["😀", "😢", "😉", "😂", "😊", "🤪", "😍", "🥳", "🤩"],
        numberOfPairs: 5,
        color: .yellow
    )
    
    static let food = Theme(
        name: "Food",
        emojis: ["🍏", "🍆", "🍒", "🍇", "🍓", "🫐", "🌽", "🥩", "🍕", "🍔", "🍗", "🍝", "🍣", "🍥", "🍨", "🍩", "🍪", "🍰", "🎂"],
        numberOfPairs: 7,
        color: .orange
    )
    
    static let nature = Theme(
        name: "Nature",
        emojis: ["🌲", "🌿", "🍀", "🌱", "🌼", "🌸", "🌈", "☀️", "❄️", "🌊", "🌍"],
        numberOfPairs: 10,
        color: .green
    )
    
    static let transport = Theme(
        name: "Transport",
        emojis: ["🚗", "🚎", "🚓", "🚒", "🚑", "🚔", "🚖", "🚗", "🚛", "🚚", "🚝", "🚞", "🚟", "🚠", "🚡", "🚢", "🚣", "🚤"],
        numberOfPairs: 10,
        color: .gray
    )
    
    static var random: Theme { themes.randomElement()! }
    
    private static let themes: [Theme] = [halloween, animals, sports, faces, food, nature, transport]
}
