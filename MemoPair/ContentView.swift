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
            Cards
            CardCountAdjusters
        }
        .padding()
    }
    
    var Cards: some View {
        HStack {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
    }
    
    var CardCountAdjusters: some View {
        HStack{
            CardAdder
            Spacer()
            CardRemover
        }
        .imageScale(.large)
    }
    
    var CardAdder: some View {
        Button(action:{
            if cardCount < emojis.count{
                cardCount += 1
            }
        }, label:{
            Image(systemName: "rectangle.stack.badge.plus.fill")
            Text("Add Card")
        })
    }
    
    var CardRemover: some View {
        Button(action:{
            if cardCount > 1{
                cardCount -= 1
            }
        }, label:{
            Text("Remove Card")
            Image(systemName: "rectangle.stack.badge.minus.fill")
        })
    }
}

struct CardView: View {
    let content:String
    @State var isFaceUp: Bool = true
    
    var baseCard: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
    
    var body: some View {
        ZStack{
            if isFaceUp {
                baseCard.fill(.white)
                baseCard.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                baseCard.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
