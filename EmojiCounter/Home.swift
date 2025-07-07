//
//  ContentView.swift
//  EmojiCounter
//
//  Created by Trey Gaines on 7/1/25.
//

import SwiftUI

struct Home: View {
    @State var myEmojis = Emojis()
    var emojis: [Character] {
        Array(myEmojis.myEmojis.keys)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(emojis, id: \.self) { emoji in
                        HStack {
                            Text("\(emoji)")
                            Text("Count: \(myEmojis.myEmojis[emoji] ?? 0)")
                                .padding(.leading, 8)

                            Spacer()
                            HStack(spacing: 8) {
                                Button {
                                    myEmojis.incrementCount(emoji)
                                } label: {
                                    Text("+")
                                        .foregroundStyle(.white)
                                        .frame(width: 30, height: 30)
                                        .background(RoundedRectangle(cornerRadius: 6).fill(Color.blue))
                                }

                                Button {
                                    myEmojis.decrementCount(emoji)
                                } label: {
                                    Text("-")
                                        .foregroundStyle(.white)
                                        .frame(width: 30, height: 30)
                                        .background(RoundedRectangle(cornerRadius: 6).fill(Color.red))
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .listRowSeparator(.hidden)
                }
                .buttonStyle(.plain)
                .ignoresSafeArea(edges: .bottom)
                
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

