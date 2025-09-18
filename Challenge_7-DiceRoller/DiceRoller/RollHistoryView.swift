//
//  RollHistoryView.swift
//  DiceRoller
//
//  Created by Georgi Ignatov on 25.08.25.
//

import SwiftUI

struct RollHistoryView: View {
    
    // MARK: Environment
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    // MARK: State
    
    @State private var isShowingClearAlert = false
    
    // MARK: Properties
    
    let rolls: [Roll]
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .orange]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            if rolls.isEmpty {
                VStack {
                    VStack {
                        Text("No rolls yet...")
                        Text("Go and roll those dice!")
                    }
                    .accessibilityElement(children: .combine)
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                            .padding(.horizontal)
                            .font(.title.bold())
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .padding()
                }
                .font(.largeTitle.bold())
            } else {
                VStack {
                    HStack {
                        Text("Dice results")
                            .font(.title.bold())
                        
                        Spacer()
                        
                        Text("Total")
                            .font(.title.bold())
                    }
                    .padding()
                    .accessibilityElement(children: .combine)
                    
                    ScrollView {
                        ForEach(rolls) { roll in
                            HStack {
                                ForEach(roll.dice) { die in
                                    Text("\(die.rollResult?.description ?? "?")")
                                        .font(.headline)
                                }
                                
                                Spacer()
                                
                                Text("\(roll.total)")
                                    .font(.title.bold())
                                    .accessibilityLabel("Total: \(roll.total)")
                            }
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 4)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 2)
                            .accessibilityElement(children: .combine)
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    HStack {
                        Button {
                            isShowingClearAlert = true
                        } label: {
                            Text("Clear")
                                .padding(.horizontal)
                                .font(.title.bold())
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .padding()
                        .tint(.red)
                        
                        Button {
                            dismiss()
                        } label: {
                            Text("Close")
                                .padding(.horizontal)
                                .font(.title.bold())
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        .padding()
                    }
                }
                .alert("Are you sure?", isPresented: $isShowingClearAlert) {
                    Button("Yes", role: .destructive) {
                        clearHistory()
                        dismiss()
                    }
                }
            }
        }
        .tint(.primary)
    }
    
    // MARK: Actions
    
    func clearHistory() {
        try? modelContext.delete(model: Roll.self)
        try? modelContext.save()
    }
}

#Preview {
    let die = Die(sides: 6)
    let roll = Roll(dice: [die, die, die, die, die])
    RollHistoryView(rolls: Array<Roll>(repeating: roll, count: 20))
}
