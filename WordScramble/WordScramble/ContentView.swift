//
//  ContentView.swift
//  WordScramble
//
//  Created by Alexandru Tenie on 12.10.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var score = 0
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                }
                
                Section {
                    Text("Score: \(score)")
                        .font(.title2)
                        .foregroundColor(.mint)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("Play", action: startGame)
                    .font(.title2)
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 1 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word already used", message: "Be more original!")
            return
        }
        
        guard isRootWord(word: answer) else {
            wordError(title: "Word is the identical to '\(rootWord)'", message: "Can't reuse the main word")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't make them up!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        changeScore(by: answer.count)
        newWord = ""
    }
    
    func startGame() {
        resetGame()
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showError = true
    }
    
    func isRootWord(word: String) -> Bool {
        newWord != rootWord
    }
    
    func resetGame() {
        usedWords.removeAll()
        score = 0
    }
    
    func changeScore(by value: Int) {
        score += value
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
