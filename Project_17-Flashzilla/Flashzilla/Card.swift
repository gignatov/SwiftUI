//
//  Card.swift
//  Flashzilla
//
//  Created by Georgi Ignatov on 5.08.25.
//

import Foundation
import SwiftData

@Model
class Card: Identifiable, Equatable {
    var id: UUID
    var prompt: String
    var answer: String
    var creationDate: Date
    
    init(id: UUID = UUID(), prompt: String, answer: String, creationDate: Date = Date()) {
        self.id = id
        self.prompt = prompt
        self.answer = answer
        self.creationDate = creationDate
    }
    
    static let example = Card(prompt: "What is Swift?", answer: "A high-level programming language.")
}
