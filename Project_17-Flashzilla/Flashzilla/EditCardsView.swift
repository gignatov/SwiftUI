//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by Georgi Ignatov on 6.08.25.
//

import SwiftData
import SwiftUI

struct EditCardsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \Card.creationDate, order: .reverse)
    private var cards: [Card]
    
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            
                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit cards")
            .toolbar {
                Button("Done", action: done)
            }
        }
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedPrompt.isEmpty, !trimmedAnswer.isEmpty else {
            return
        }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        modelContext.insert(card)
        
        newPrompt = ""
        newAnswer = ""
    }
    
    func removeCards(at offsets: IndexSet) {
        for offset in offsets {
            let card = cards[offset]
            modelContext.delete(card)
        }
    }
    
    func done() {
        dismiss()
    }
}

#Preview {
    EditCardsView()
}
