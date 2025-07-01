//
//  ContentView.swift
//  EmojiCounter
//
//  Created by Trey Gaines on 7/1/25.
//

import SwiftUI

struct Home: View {
    @State var myEmojis = Emojis()
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach($myEmojis.myEmojis, id: \.self, editActions: .delete) { emoji in
                        Text("\(emoji.wrappedValue)")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.largeTitle)
                        
                    }
                    .listRowSeparator(.hidden)
                }.ignoresSafeArea(edges: .bottom)
                
                VStack {
                    Spacer()
                    HStack {
                        MyButton(image: "plus", action: { myEmojis.incrementEmojis() }, color: Color.blue, padding: 6)
                        Spacer()
                        MyButton(image: "minus", action: { myEmojis.decrementEmoji() }, color: Color.red, padding: 16)
                    }.padding(.all, 5)
                }
            }
            .navigationTitle("My Emojis")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    Home()
        .preferredColorScheme(.dark)
}

struct MyButton: View {
    var image: String
    var action: () -> Void
    var color: Color
    var padding: CGFloat
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: image)
                .padding(.all, padding)
                .font(.title)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .opacity(0.75)
                .background {
                    Circle().fill(color)
                        .opacity(0.5)
                }
        }
    }
}

