//
//  Move.swift
//  RockPaperScissors
//
//  Created by Georgi Ignatov on 13.05.25.
//

import Foundation

enum Move: Int, CaseIterable {
    case rock
    case paper
    case scissors
    
    var title: String {
        switch self {
        case .rock:
            return "Rock"
        case .paper:
            return "Paper"
        case .scissors:
            return "Scissors"
        }
    }
    
    var emoji: String {
        switch self {
        case .rock:
            return "🪨"
        case .paper:
            return "📄"
        case .scissors:
            return "✂️"
        }
    }
}
