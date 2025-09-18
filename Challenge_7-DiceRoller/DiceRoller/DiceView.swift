//
//  DiceView.swift
//  DiceRoller
//
//  Created by Georgi Ignatov on 12.08.25.
//

import SwiftUI

struct DiceView: View {
    let dice: [Die]
    let itemsPerRow: Int
    let numberOfSides: Int
    let diceColors: [Color]
    
    init(dice: [Die], itemsPerRow: Int, numberOfSides: Int, diceColors: [Color]) {
        self.dice = dice
        self.itemsPerRow = itemsPerRow
        self.numberOfSides = numberOfSides
        self.diceColors = diceColors
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            let rows = (dice.count - 1) / itemsPerRow + 1
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 10) {
                    Spacer(minLength: 10)
                    
                    var itemsInRow: Int {
                        if dice.count >= (row + 1) * itemsPerRow {
                            itemsPerRow
                        } else {
                            dice.count % itemsPerRow
                        }
                    }
                    
                    ForEach(0..<itemsInRow, id: \.self) { position in
                        ZStack {
                            let itemIndex = row * itemsPerRow + position
                            let die = dice[itemIndex]
                            let color = diceColors[itemIndex]
                            let sideSize = UIScreen.main.bounds.size.width / 3 - 40
                            
                            Text("\(die.rollResult?.description ?? "")")
                                .font(.title.bold())
                                .padding()
                                .frame(width: sideSize, height: sideSize)
                                .foregroundStyle(.primary)
                                .background {
                                    DieShape(sides: numberOfSides)
                                        .foregroundStyle(color)
                                        .frame(maxWidth: .infinity)
                                        .aspectRatio(1, contentMode: .fit)
                                }
                            
                            DieShape(sides: numberOfSides)
                                .stroke(style: StrokeStyle(lineWidth: 3))
                                .frame(width: sideSize, height: sideSize)
                        }
                    }
                    
                    Spacer(minLength: 10)
                }
            }
            
            Spacer()
        }
        .accessibilityLabel("Dice results: \(dice.compactMap(\.rollResult?.description).joined(separator: ", "))")
    }
}

#Preview {
    DiceView(dice: [Die(sides: 5), Die(sides: 5), Die(sides: 5), Die(sides: 5), Die(sides: 5)],
             itemsPerRow: 3,
             numberOfSides: 5,
             diceColors: [.red, .blue, .green, .yellow, .purple])
}
