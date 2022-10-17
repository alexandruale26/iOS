//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Alexandru Tenie on 12.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    let icons = ["circle.inset.filled", "doc.circle.fill", "scissors.circle.fill"]
    let rps = ["rock", "paper", "scissors"]
    
    @State var aiChoice: Int = .random(in: 0..<3)
    @State var shouldWin: Bool  = .random()
    @State var showAlert = false

    @State var score = 0
    @State var rounds = 0
        
    var body: some View {
        VStack {
            Group {
                Spacer()
                Spacer()
                Text(shouldWin ? "Player should WIN" : "Player should LOSE")
                    .font(.largeTitle)
            }
            
            Group {
                Spacer()
                Image(systemName: icons[aiChoice])
                    .font(.system(size: 200))
                    .foregroundStyle(shouldWin ? .green : .red)
                
                Spacer()
            }
            
            HStack {
                ForEach(0..<icons.count, id: \.self) {index in
                    Button {
                        getResult(of: index)
                    } label: {
                        Image(systemName: icons[index])
                            .font(.system(size: 100))
                            .foregroundStyle(.teal)
                    }
                }
            }
            .alert("Game Over", isPresented: $showAlert) {
                Button("Restart", action: restart)
            } message: {
                Text("You scored \(score) points")
            }
            
            Group {
                Spacer()
                Spacer()
                Text("Score \(score)")
                    .font(.title)
                Spacer()
            }
        }
        .padding()
    }
    
    func getResult(of choice: Int) {
        if shouldWin {
            if rps[aiChoice] == "rock" && rps[choice] == "paper" {
                score += 1
            } else if rps[aiChoice] == "paper" && rps[choice] == "scissors" {
                score += 1
            } else if rps[aiChoice] == "scissors" && rps[choice] == "rock" {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if rps[aiChoice] == "rock" && rps[choice] == "scissors" {
                score += 1
            } else if rps[aiChoice] == "paper" && rps[choice] == "rock" {
                score += 1
            } else if rps[aiChoice] == "scissors" && rps[choice] == "paper" {
                score += 1
            } else {
                score -= 1
            }
        }
        
        rounds += 1
        aiChoice = .random(in: 0..<3)
        shouldWin = .random()
        
        if rounds == 10 {
            showAlert = true
        }
    }
    
    func restart() {
        rounds = 0
        score  = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
