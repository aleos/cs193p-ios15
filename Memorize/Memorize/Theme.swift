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
    let numberOfPairs: Int?
    let colorStyle: ThemeColorStyle
}

extension Theme: Identifiable {
    var id: String { name }
}

enum ThemeColorStyle {
    case solid(Color)
    case linearGradient(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint)
    case angularGradient(colors: [Color], center: UnitPoint, angle: Angle)
}

extension Theme {
    static let halloween = Theme(
        name: "Halloween",
        emojis: ["👻", "🎃", "🕷️", "😈", "💀", "❄️", "🧙‍♂️", "🙀", "👹", "😱", "☠️", "🍂", "⚰️", "🪦"],
        numberOfPairs: nil,
        colorStyle: .linearGradient(
            colors: [.red, .orange, .yellow, .green, .blue, .purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    )
    
    static let animals = Theme(
        name: "Animals",
        emojis: ["🐼", "🐔", "🦄", "🐶", "🐱", "🐭", "🐽", "🐍", "🐒"],
        numberOfPairs: 9,
        colorStyle: .angularGradient(
            colors: [.red, .orange, .yellow, .green, .blue, .purple],
            center: .center,
            angle: .degrees(120)
        )
    )
    
    static let sports = Theme(
        name: "Sports",
        emojis: ["🏀", "🏈", "⚾", "🎱", "🥊", "🥋", "🎮", "🥎", "🏐"],
        numberOfPairs: 8,
        colorStyle: .solid(.red)
    )
    
    static let faces = Theme(
        name: "Faces",
        emojis: ["😀", "😢", "😉", "😂", "😊", "🤪", "😍", "🥳", "🤩"],
        numberOfPairs: 5,
        colorStyle: .solid(.yellow)
    )
    
    static let food = Theme(
        name: "Food",
        emojis: ["🍏", "🍆", "🍒", "🍇", "🍓", "🫐", "🌽", "🥩", "🍕", "🍔", "🍗", "🍝", "🍣", "🍥", "🍨", "🍩", "🍪", "🍰", "🎂"],
        numberOfPairs: nil,
        colorStyle: .solid(.orange)
    )
    
    static let nature = Theme(
        name: "Nature",
        emojis: ["🌲", "🌿", "🍀", "🌱", "🌼", "🌸", "🌈", "☀️", "❄️", "🌊", "🌍"],
        numberOfPairs: 10,
        colorStyle: .solid(.green)
    )
    
    static let transport = Theme(
        name: "Transport",
        emojis: ["🚗", "🚎", "🚓", "🚒", "🚑", "🚔", "🚖", "🚗", "🚛", "🚚", "🚝", "🚞", "🚟", "🚠", "🚡", "🚢", "🚣", "🚤"],
        numberOfPairs: 10,
        colorStyle: .solid(.gray)
    )
    
    static var random: Theme { themes.randomElement()! }
    
    private static let themes: [Theme] = [halloween, animals, sports, faces, food, nature, transport]
}

import SwiftUI

extension View {
    @ViewBuilder
    func applyForegroundStyle(_ style: ThemeColorStyle) -> some View {
        switch style {
        case .solid(let color):
            foregroundStyle(color)
        case .linearGradient(let colors, let startPoint, let endPoint):
            foregroundStyle(
                LinearGradient(colors: colors, startPoint: startPoint, endPoint: endPoint)
            )
        case .angularGradient(let colors, let center, let angle):
            foregroundStyle(
                AngularGradient(colors: colors, center: center, angle: angle)
            )
        }
    }
}
