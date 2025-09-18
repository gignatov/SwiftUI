//
//  ContentView.swift
//  Flashzilla
//
//  Created by Georgi Ignatov on 5.08.25.
//

import SwiftData
import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.modelContext) var modelContext
    
    @State private var cards: [Card] = []
    @State private var timeRemaining = 100
    @State private var isActive = true
    @State private var showingEditScreen = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                ZStack {
                    ForEach(cards) { card in
                        let index = cards.firstIndex(of: card)!
                        
                        CardView(card: card) { isCorrect in
                            withAnimation {
                                removeCard(at: index, isCorrect: isCorrect)
                            }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1)
                        .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(.capsule)
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }
                
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, isCorrect: false)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, isCorrect: true)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active, !cards.isEmpty {
                isActive = true
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCardsView.init)
        .onAppear(perform: resetCards)
    }
    
    func loadData() {
        let sortDescriptor = SortDescriptor<Card>(\.creationDate, order: .reverse)
        if let cards = try? modelContext.fetch(FetchDescriptor<Card>(sortBy: [sortDescriptor])) {
            self.cards = cards
        }
    }
        
    func removeCard(at index: Int, isCorrect: Bool) {
        guard index >= 0 else { return }
        
        let card = cards.remove(at: index)
        if !isCorrect {
            cards.insert(card, at: 0)
        }
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        loadData()
        timeRemaining = 100
        isActive = true
    }
}

#Preview {
    ContentView()
}
