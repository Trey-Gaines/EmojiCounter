//
//  Observable.swift
//  EmojiCounter
//
//  Created by Trey Gaines on 7/1/25.
//

import Observation

@Observable
class Emojis {
    var myEmojis: [Character]
    var emojiST: Set<Character>
    var ranges: Set<ClosedRange<Int>> {
        didSet {
            if ranges.count == 0 {
                ranges = [0x1F601...0x1F64F, 0x2702...0x27B0, 0x1F680...0x1F6C0, 0x1F170...0x1F251]
            }
        }
    }
    
    init(currentEmojis: [Character] = [], emojiST: Set<Character> = [], ranges: Set<ClosedRange<Int>> = []) {
        self.myEmojis = currentEmojis
        self.emojiST = emojiST
        self.ranges = [0x1F601...0x1F64F, 0x2702...0x27B0, 0x1F680...0x1F6C0, 0x1F170...0x1F251]
    }
    
    func incrementEmojis() {
        let emoji = randomEmoji()
        myEmojis.append(emoji)
        emojiST.insert(emoji)
    }
    
    func decrementEmoji() {
        if let emoji = myEmojis.popLast() {
            emojiST.remove(emoji)
        }
    }
    
    func randomEmoji() -> Character {
        let myRange: ClosedRange<Int> = ranges.randomElement()!
        ranges.remove(myRange)
        
        for each in myRange {
            if let scaler = UnicodeScalar(each), !emojiST.contains(Character(String(scaler))) {
                let str = String(scaler)
                let char = Character(str)
                return char
            } else { continue }
        }
        return "🌎"
    }
}

