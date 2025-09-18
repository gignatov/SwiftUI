//
//  Die.swift
//  DiceRoller
//
//  Created by Georgi Ignatov on 7.08.25.
//

import Foundation
import SwiftData

@Model
class Die: Identifiable {
    private(set) var id = UUID()
    private(set) var sides: Int
    private(set) var rollResult: Int?
    
    init(sides: Int) {
        self.sides = sides
    }
    
    func roll() {
        rollResult = Int.random(in: 1...sides)
    }
}
