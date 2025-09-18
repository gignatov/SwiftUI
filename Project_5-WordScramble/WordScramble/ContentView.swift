//
//  ContentView.swift
//  WordScramble
//
//  Created by Georgi Ignatov on 13.05.25.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        TextField("Enter your word", text: $newWord)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }
                    
                    Section {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                            .accessibilityElement()
                            .accessibilityLabel(word)
                            .accessibilityHint("\(word.count) letters")
                        }
                    }
                }
                
                Text("Score: \(score)")
                    .font(.title.weight(.semibold))
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("Restart", action: startGame)
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from \(rootWord)!")
            return
        }
        
        guard isRealWord(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isEnoughCharacters(word: answer) else {
            wordError(title: "Word is too short", message: "Don't be lazy, add a few more letters!")
            return
        }
        
        guard !isStartingWord(word: answer) else {
            wordError(title: "Word is the same as starting word", message: "You can't just use the starting word, think of something new!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        addScore(word: answer)
        newWord = ""
    }
    
    func startGame() {
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
              let startWords = try? String(contentsOf: startWordsURL, encoding: .ascii) else {
            fatalError("Could not load start.txt from bundle.")
        }
        
        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"
        score = 0
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            guard let range = tempWord.firstIndex(of: letter) else { return false }
            tempWord.remove(at: range)
        }
        
        return true
    }
    
    func isRealWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspellings = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspellings.location == NSNotFound
    }
    
    func isEnoughCharacters(word: String) -> Bool {
        word.count >= 3
    }
    
    func isStartingWord(word: String) -> Bool {
        word == rootWord
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func addScore(word: String) {
        var newScore = score
        
        if word.count == 8 {
            newScore += 10
        } else {
            newScore += word.count
        }
        
        score = newScore
    }
}

#Preview {
    ContentView()
}
