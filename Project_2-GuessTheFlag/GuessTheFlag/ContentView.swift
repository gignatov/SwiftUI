//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Georgi Ignatov on 4.04.25.
//

import SwiftUI

struct ContentView: View {
    
    private enum Constant {
        static let numberOfFlags = 3
    }
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0..<Constant.numberOfFlags)
    
    @State private var showingScore = false
    @State private var showingGameOver = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var currentQuestion = 1
    
    @State private var selectedAnswer: Int?
    @State private var rotationDegrees = 0.0
    @State var scale = 1.0
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, Bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, Bottom stripe yellow.",
        "US": "Flag with many white and red stripes, with white stars on a blue background in the top-left corner."
    ]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<Constant.numberOfFlags, id: \.self) { number in
                        if let selectedAnswer {
                            if selectedAnswer == number {
                                Button() {
                                    flagTapped(number)
                                } label: {
                                    FlagImage(imageName: countries[number])
                                }
                                .rotation3DEffect(.degrees(rotationDegrees),
                                                  axis: (x: 0, y: 1, z: 0))
                                .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                            } else {
                                Button() {
                                    flagTapped(number)
                                } label: {
                                    FlagImage(imageName: countries[number])
                                }
                                .opacity(0.25)
                                .scaleEffect(scale)
                                .animation(.spring, value: scale)
                                .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                            }
                        } else {
                            Button() {
                                flagTapped(number)
                            } label: {
                                FlagImage(imageName: countries[number])
                            }
                            .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: proceedToNextRound)
        } message: {
            Text ("Your score is \(score)")
        }
        .alert("Game Over!", isPresented: $showingGameOver) {
            Button("Restart", action: restartGame)
        } message: {
            Text ("Your final score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        scale = 0.7

        withAnimation {
            selectedAnswer = number
            rotationDegrees += 360
        }
        
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...Constant.numberOfFlags)
    }
    
    func proceedToNextRound() {
        selectedAnswer = nil
        
        if currentQuestion < 8 {
            currentQuestion += 1
            askQuestion()
        } else {
            showingGameOver = true
        }
    }
    
    func restartGame() {
        currentQuestion = 1
        score = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
