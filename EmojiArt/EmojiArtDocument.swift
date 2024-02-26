//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Anastasia Lulakova on 16.02.2024.
//

import SwiftUI


class EmojiArtDocument: ObservableObject {
    typealias Emoji = EmojiArt.Emoji
    
    @Published private var emojiArt = EmojiArt()
    
    init() {
        emojiArt.addEmoji("🧚🏻", at: .init(x: -200, y: -230), size: 300)
        emojiArt.addEmoji("🦹🏼‍♂️", at: .init(x: 250, y: 100), size: 80)
    }
    
    var emojis: [Emoji] {
        emojiArt.emojis
    }
    
    var background : URL? {
        emojiArt.background
    }
    
    //MARK: - Intend(s)
    
    func setBackground (_ url: URL?) {
        emojiArt.background = url
    }
    
    func addEmoji(_ emoji: String, position: Emoji.Position, size: CGFloat) {
        emojiArt.addEmoji(emoji, at: position, size: Int(size))
    }
    
    func zoomEmojiSize(_ id: Int, to zoom: CGFloat) {
        emojiArt.resizeEmoji(id, scale: Float(zoom))
    }
    
    func moveEmojis(_ id: Int, offset: CGOffset, zoom:CGFloat){
        emojiArt.moveEmoji(id, offset: Emoji.Position(x: Int(offset.width/zoom), y: Int(offset.height/zoom)))
    }
    
    func deleteEmoji(_ id: Int){
        emojiArt.deleteEmoji(id)
    }
}

extension EmojiArt.Emoji {
    var font: Font {
        Font.system(size: CGFloat(size))
    }
}

extension EmojiArt.Emoji.Position {
    func `in`(_ geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(x: center.x + CGFloat(x), y: center.y - CGFloat(y))
    }
}
