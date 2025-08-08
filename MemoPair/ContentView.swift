//
//  ContentView.swift
//  MemoPair
//
//  Created by 李 on 2025/7/30.
//

import SwiftUI

struct ContentView: View {
    
    let emojis: [String] = ["👻","🎃","🕷️","😈","☠️","🧟","🕸️","🧙‍♀️"]
    
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack{
            ScrollView{ cards }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack{
            cardAdder
            Spacer()
            cardRemover
        }
        .imageScale(.large)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action:{
            cardCount += offset
        }, label:{
            VStack{
                Image(systemName: symbol)
            }
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
}

struct CardView: View {
    let content:String
    @State var isFaceUp: Bool = true
    
    var baseCard: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
    
    var body: some View {
        ZStack{
            Group {
                baseCard.fill(.white)
                baseCard.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            baseCard.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .aspectRatio(3/4, contentMode: .fit)
        .onTapGesture {
            isFaceUp.toggle()
        }
        
    }
}

#Preview {
    ContentView()
}
