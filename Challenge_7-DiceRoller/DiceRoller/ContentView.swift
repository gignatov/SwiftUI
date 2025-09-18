//
//  ContentView.swift
//  DiceRoller
//
//  Created by Georgi Ignatov on 7.08.25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    // MARK: Constants
    
    private enum Constant {
        static let diceColorOptions: [Color] = [.red, .green, .blue, .yellow, .pink, .purple, .orange, .cyan, .indigo, .mint, .teal, .brown]
        static let itemsPerRow = 3
    }
    
    // MARK: Environment
    
    @Environment(\.modelContext) private var modelContext
    
    // MARK: Query
    
    @Query(sort: [
        SortDescriptor(\Roll.date, order: .reverse)
    ]) private var rollHistory: [Roll]
    
    // MARK: State
    
    @State private var numberOfDice = 1
    @State private var numberOfSides = 6
    
    @State private var dice: [Die] = []
    @State private var isRolling = false
    @State private var diceColors: [Color] = []
    
    @State private var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    @State private var timerTick = 0
    @State private var currentRollingDie: Die?
    @State private var isShowingRollResult = false
    @State private var rollFinishTrigger = false
    
    @State private var isShowingRollHistory = false
    
    // MARK: Properties
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 3
        formatter.minimum = 3
        formatter.maximum = 999
        return formatter
    }()
    
    // MARK: Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .orange]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                VStack {
                    VStack {
                        Text("Last roll:")
                            .font(.title.bold())
                        
                        let lastRoll = rollHistory.first
                        Text("\(lastRoll?.total.description ?? "Roll the dice!")")
                            .font(.title.bold())
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(isShowingRollResult ? Color.systemBackground : .primary)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 4)
                            }
                    }
                    .accessibilityElement(children: .combine)
                    
                    DiceView(dice: dice,
                             itemsPerRow: Constant.itemsPerRow,
                             numberOfSides: numberOfSides,
                             diceColors: diceColors)
                    .foregroundStyle(isShowingRollResult ? Color.systemBackground : .primary)
                    .background {
                        Color.primary
                            .clipShape(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 4)
                            )
                            .padding(.vertical)
                    }
                    
                    HStack {
                        Text("Number of sides")
                            .font(.title.bold())
                            .accessibilityLabel("Number of sides: \(numberOfSides)")
                        Spacer()
                        
                        TextField("", value: $numberOfSides, formatter: formatter)
                            .keyboardType(.numberPad)
                            .font(.largeTitle.bold())
                            .frame(width: 120)
                            .multilineTextAlignment(.center)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 4)
                            }
                            .onChange(of: numberOfSides) { oldValue, newValue in
                                if newValue > 999 {
                                    numberOfSides = oldValue
                                }
                                
                                resetRollResultIfNeeded()
                                updateDiceSides()
                            }
                    }
                    
                    HStack {
                        Text("Number of dice")
                            .font(.title.bold())
                            .accessibilityLabel("Number of dice: \(numberOfDice)")
                        
                        Spacer()
                        
                        Button {
                            numberOfDice -= 1
                        } label: {
                            Image(systemName: "minus.circle")
                        }
                        .font(.largeTitle)
                        .disabled(numberOfDice <= 1)
                        .accessibilityLabel("Decrease number of dice")
                        
                        Text("\(numberOfDice)")
                            .font(.largeTitle.bold())
                            .frame(width: 25)
                            .multilineTextAlignment(.center)
                            .accessibilityHidden(true)
                        
                        Button {
                            numberOfDice += 1
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                        .font(.largeTitle)
                        .disabled(numberOfDice >= 5)
                        .accessibilityLabel("Increase number of dice")
                    }
                    .onChange(of: numberOfDice) {
                        resetRollResultIfNeeded()
                        
                        while numberOfDice > dice.count {
                            withAnimation(.spring(duration: 0.3, bounce: 0.4)) {
                                addDie()
                            }
                        }
                        while numberOfDice < dice.count {
                            withAnimation(.spring(duration: 0.3, bounce: 0.4)) {
                                removeDie()
                            }
                        }
                    }
                    
                    Button {
                        resetRollResultIfNeeded()
                        startTimer()
                        isRolling = true
                    } label: {
                        Text("Roll")
                            .padding(.horizontal)
                            .font(.title.bold())
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .padding()
                }
                .padding()
            }
            .onTapGesture {
                dismissKeyboard()
            }
            .onAppear {
                stopTimer()
                resetDice()
            }
            .onReceive(timer) { _ in
                rollDice()
            }
            .allowsHitTesting(!isRolling)
            .sensoryFeedback(.impact(weight: .heavy), trigger: currentRollingDie)
            .sensoryFeedback(.success, trigger: rollFinishTrigger)
            .toolbar {
                Button {
                    isShowingRollHistory = true
                } label: {
                    Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                }
                .accessibilityLabel("Roll History")
            }
            .sheet(isPresented: $isShowingRollHistory) {
                RollHistoryView(rolls: rollHistory)
            }
            .ignoresSafeArea(.keyboard)
        }
        .tint(.primary)
    }
    
    // MARK: Actions
    
    func addDie() {
        let die = Die(sides: numberOfSides)
        dice.append(die)
        diceColors.append(Constant.diceColorOptions.randomElement() ?? .red)
    }
    
    func removeDie() {
        guard !dice.isEmpty else { return }
        dice.removeLast()
        
        guard !diceColors.isEmpty else { return }
        diceColors.removeLast()
    }
    
    func resetDice() {
        dice.removeAll()
        diceColors.removeAll()
        
        for _ in 0..<numberOfDice {
            let die = Die(sides: numberOfSides)
            dice.append(die)
            diceColors.append(Constant.diceColorOptions.randomElement() ?? .red)
        }
    }
    
    func resetRollResultIfNeeded() {
        if isShowingRollResult {
            resetDice()
            withAnimation {
                isShowingRollResult = false
            }
        }
    }
    
    func updateDiceSides() {
        dice.removeAll()
        
        for _ in 0..<numberOfDice {
            let die = Die(sides: numberOfSides)
            dice.append(die)
        }
    }
    
    func rollDice() {
        if timerTick % 5 == 0 {
            currentRollingDie = dice.first { $0.rollResult == nil }
        }
        
        if let currentRollingDie {
            currentRollingDie.roll()
            timerTick += 1
        } else {
            withAnimation {
                rollFinishTrigger.toggle()
                currentRollingDie = nil
                isRolling = false
                let roll = Roll(dice: dice)
                saveRoll(roll: roll)
                isShowingRollResult = true
                stopTimer()
                timerTick = 0
            }
        }
    }
    
    func startTimer() {
        timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
    }
    
    func saveRoll(roll: Roll) {
        modelContext.insert(roll)
        try? modelContext.save()
    }
}

#Preview {
    ContentView()
}
