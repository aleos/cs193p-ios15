//
//  ContentView.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 22/9/2024.
//

import SwiftUI

struct ContentView: View {
    private static let themes: [Theme] = [.animals, .food, .nature]
    
    @State private var currentTheme: Theme = .animals
    @State private var emojis: [String] = Theme.animals.shuffled
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themePicker
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 45))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(currentTheme.foregroundColor)
    }
    
    var themePicker: some View {
        HStack(alignment: .lastTextBaseline) {
            ForEach(Self.themes.indices, id: \.self) { index in
                let theme = Self.themes[index]
                Button {
                    currentTheme = theme
                    emojis = theme.shuffled
                } label: {
                    VStack {
                        theme.icon
                            .imageScale(.large)
                            .font(.title2)
                        Text(theme.name)
                            .font(.caption)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
