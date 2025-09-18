//
//  Roll.swift
//  DiceRoller
//
//  Created by Georgi Ignatov on 7.08.25.
//

import Foundation
import SwiftData

@Model
class Roll: Identifiable {
    private(set) var id = UUID()
    private(set) var dice: [Die]
    private(set) var total: Int
    private(set) var date = Date()
    
    init(dice: [Die]) {
        self.dice = dice
        
        var total = 0
        let results = dice.compactMap { $0.rollResult }
        results.forEach { total += $0 }
        self.total = total
    }
}
