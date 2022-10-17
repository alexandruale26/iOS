//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Alexandru Tenie on 05.10.2022.
//

import SwiftUI

struct FlagImage: View {
    
    let flagName: String
    
    var body: some View {
        Image(flagName)
            .renderingMode(.original)
            .clipShape(Rectangle())
            .cornerRadius(40)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State var showingScore = false
    @State var showGameOver = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var counter = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                stops: [.init(color: .mint, location: 0.3), .init(color: .red.opacity(0.9), location: 0.3)],
                center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack {
                    VStack {
                        Text("Tap the flag of")
                            .font(.title2.bold())
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundColor(.white)
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number, of: countries[number])
                        } label: {
                            FlagImage(flagName: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score \(score)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Spacer()
                }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }
        .alert("Game Over", isPresented: $showGameOver) {
            Button("Restart Game", action: askToReset)
        } message: {
            Text("You scored \(score) points")
        }
    }
    
    func flagTapped(_ number: Int, of country: String) {
        if (number == correctAnswer) {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(country)"
        }
        
        counter += 1
        
        if counter < 8 {
            showingScore = true
        } else {
          showGameOver = true
        }
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func askToReset() {
        score = 0
        counter = 0
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
