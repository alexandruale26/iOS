//
//  CryptoBuddyApp.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 10.01.2023.
//

import SwiftUI

@main
struct CryptoBuddyApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    var body: some Scene {
        
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .toolbar(.hidden)
                }
                .environmentObject(vm)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
    
    init() {
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
}
