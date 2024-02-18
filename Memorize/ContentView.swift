//
//  ContentView.swift
//  Memorize
//
//  Created by Kris Mata on 2/4/24.
//

import SwiftUI

struct ContentView: View {
    let halloweenEmojis = ["🎃", "👻", "💀", "🦇", "🕸️", "🕷️", "🍭", "🍬", "🍫", "🔮"]
    let christmasEmojis = ["🎄", "🎅", "🤶", "🎁", "🌟", "☃️"]
    let animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐒", "🐔", "🐧", "🐦", "🦉", "🐺", "🐗", "🐴", "🦄", "🐝", "🐛", "🦋", "🐌"]
    @State var selectedTypeEmojis = 1;

    @State var cardCount: Int = 4
    
    @State var selectedEmojis: [String] = []
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards(emojis: selectedEmojis)
            }.onAppear {
                selectedEmojis = halloweenEmojis
            }
            Spacer()
            //cardCountAdjusters
            HStack(spacing: 40, content: {
                buttomThemeSelector(type: 1, label: "🎃")
                buttomThemeSelector(type: 2, label: "🎄")
                buttomThemeSelector(type: 3, label: "🐶")
            })
        }
        .padding(20)
    }
    
    func buttomThemeSelector(type: Int, label: String) -> some View {
        Button(action: {
            selectedTypeEmojis = type
            selectedEmojis = selectedTypeEmojis == 1 ? halloweenEmojis : selectedTypeEmojis == 2 ? christmasEmojis : animalEmojis
            selectedEmojis = selectedEmojis + selectedEmojis
            selectedEmojis = selectedEmojis.shuffled()
            print(selectedEmojis)
        }, label: {
            Text(label)
        }).font(.largeTitle)
            .border(selectedTypeEmojis == type ? Color.black : Color.white)
    }
    
    func cards(emojis: [String]) -> some View {
        return LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/2, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            }
        }.foregroundColor(.blue)
    }
    
//    var cardCountAdjusters: some View {
//        HStack (spacing: 60) {
//            cardRemover
//            cardAdder
//        }
//    }
//    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        return Button(action: {
//            cardCount += offset
//        }, label: {
//            Image(systemName: symbol).font(.largeTitle)
//        }).disabled(cardCount + offset > emojis.count || cardCount + offset < 0)
//    }
//    
//    var cardRemover: some View {
//        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//    }
//    
//    var cardAdder: some View {
//        return cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
//    }
}


struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack (alignment: .center, content:
                    {
            let base : RoundedRectangle = RoundedRectangle(cornerRadius: 20)
            base.strokeBorder(style: StrokeStyle(lineWidth: 4))
            Group{
                Text(content).multilineTextAlignment(.center).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }).onTapGesture {
            print("tapped")
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
