//
//  Observable.swift
//  EmojiCounter
//
//  Created by Trey Gaines on 7/1/25.
//

import Observation

@Observable
class Emojis {
    var myEmojis: [Character: Int]
    var emojiST: Set<Character>
    var ranges: Set<ClosedRange<Int>> {
        didSet {
            if ranges.count == 0 {
                ranges = [0x1F601...0x1F64F, 0x2702...0x27B0, 0x1F680...0x1F6C0, 0x1F170...0x1F251]
            }
        }
    }
    
    init(currentEmojis: [Character: Int] = [:], emojiST: Set<Character> = [], ranges: Set<ClosedRange<Int>> = []) {
        self.myEmojis = currentEmojis
        self.emojiST = emojiST
        self.ranges = [0x1F601...0x1F64F, 0x2702...0x27B0, 0x1F680...0x1F6C0, 0x1F170...0x1F251]
    }
    
    func incrementEmojis() {
        let emoji = randomEmoji()
        if let myCount = myEmojis[emoji] {
            myEmojis[emoji] = myCount + 1
        } else {
            myEmojis[emoji] = 1
        }
        emojiST.insert(emoji)
    }
    
    func decrementEmoji() {
        guard !myEmojis.isEmpty else { return }
        let randomKey = myEmojis.keys.randomElement()!
        myEmojis.removeValue(forKey: randomKey)
    }
    
    func decrementCount(_ key: Character) {
        guard let count = myEmojis[key] else { return }
        if count == 1 {
            myEmojis.removeValue(forKey: key)
            emojiST.remove(key)
        } else {
            myEmojis[key]! -= 1
        }
    }
    
    func incrementCount(_ key: Character) {
        myEmojis[key]! += 1
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

