//
//  ContentView.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 22/9/2024.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "❄️", "🧙‍♂️", "🙀", "👹", "😱", "☠️", "🍭"]
    
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
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
