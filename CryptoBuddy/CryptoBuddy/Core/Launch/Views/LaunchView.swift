//
//  LaunchView.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 15.01.2023.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Loading your portfolio...".map { String($0) }
    @State private var showLoading: Bool = false
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack {
                if showLoading {
                    HStack(spacing: 1) {
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.launch.accent)
                                .offset(y: counter == index ? -10 : 0)
                        }
                    }
                    .transition(.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoading.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    
                    if loops >= 1 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
