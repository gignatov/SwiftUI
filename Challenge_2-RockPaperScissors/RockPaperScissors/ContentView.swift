//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Georgi Ignatov on 13.05.25.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Constants
    
    private enum Constant {
        static let numberOfTurns = 10
    }
    
    // MARK: - State
    
    @State private var showingFinalScore = false
    
    @State private var score = 0
    @State private var turn = 0
    
    @State private var computerMove: Move = .rock
    
    @State private var shouldWin = false
    @State private var conditionWinText = ""
    @State private var conditionLoseText = ""
    @State private var conditionTextColor: Color = .red
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [.init(color: .purple, location: 0),
                                   .init(color: .black, location: 0.2),
                                   .init(color: .black, location: 0.8),
                                   .init(color: .pink, location: 1)],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            
            VStack {
                Spacer()
                Text("Score: \(score)")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Spacer()
                Text("Computer chose **\(computerMove.title)**")
                    .font(.title)
                    .foregroundStyle(.white)
                
                Text(shouldWin ? conditionWinText : conditionLoseText)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(conditionTextColor)
                
                Spacer()
                HStack {
                    Spacer()
                    ForEach(Move.allCases, id: \.self) { move in
                        Button(move.emoji) {
                            handlePlayerMove(move)
                        }
                        .font(.system(size: 100))
                        .buttonStyle(.bordered)
                    }
                    Spacer()
                }
                Spacer()
                Spacer()
            }
        }
        .onAppear() {
            prepareGame()
        }
        .alert("Game Over!", isPresented: $showingFinalScore) {
            Button("Restart", action: resetGame)
        } message: {
            Text ("Your final score is \(score)")
        }
    }
}

// MARK: - Helpers

private extension ContentView {
    func handlePlayerMove(_ move: Move) {
        updateScore(move)
        handleNextTurn()
    }
    
    func updateScore(_ move: Move) {
        if checkIfMoveWins(move) == shouldWin {
            score += 1
        } else if score > 0 {
            score -= 1
        }
    }
    
    func checkIfMoveWins(_ move: Move) -> Bool {
        switch (move, computerMove) {
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            return true
        default:
            return false
        }
    }
    
    func handleNextTurn() {
        if turn == Constant.numberOfTurns {
            showingFinalScore = true
        } else {
            prepareNextTurn()
        }
    }
    
    func prepareNextTurn() {
        turn += 1
        computerMove = Move.allCases.randomElement() ?? .rock
        shouldWin = Bool.random()
        conditionWinText = Bool.random() ? "You should win" : "You shouldn't lose"
        conditionLoseText = Bool.random() ? "You shouldn't win" : "You should lose"
        conditionTextColor = Bool.random() ? .green : .red
    }
    
    func prepareGame() {
        score = 0
        turn = 0
        prepareNextTurn()
    }
    
    func resetGame() {
        prepareGame()
    }
}

#Preview {
    ContentView()
}
