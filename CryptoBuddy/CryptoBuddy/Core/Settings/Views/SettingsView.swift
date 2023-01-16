//
//  SettingsView.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 15.01.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: HomeViewModel
    
    private let defaultURL = URL(string: "https://www.google.com")!
    private let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    private let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    private let coingeckoURL = URL(string: "https://www.coingecko.com")!
    private let personalURL = URL(string: "https://www.nicksarno.com")!
    
    var body: some View {
        
        NavigationView {
            List {
                swiftfulThinkingSection
                coinGeckoSection
                developerSection
                applicationSection
            }
            .navigationTitle("Settings")
            .listStyle(.grouped)
            .tint(.blue)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(dismissAction: dismiss)
                }
            }
        }
    }
}

extension SettingsView {
    
    private var swiftfulThinkingSection: some View {
        
        Section("Swiftful Thinking") {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                
                Text("This app was made by following a @SwiftfulThinking course on YouTube. It uses MVVM Architecture, Combine, and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Subscribe on YouTube  🥳", destination: youtubeURL)
            Link("Support his coffee addiction  ☕️", destination: coffeeURL)
        }
    }
    
    private var coinGeckoSection: some View {
        
        Section("CoinGecko") {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .cornerRadius(20)
                
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Visit CoinGecko", destination: coingeckoURL)
        }
    }
    
    private var developerSection: some View {
        
        Section("Developer") {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                
                Text("This app was developed by Nick Sarno. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Visit Website 🤙", destination: personalURL)
        }
    }
    
    private var applicationSection: some View {
        
        Section("Application") {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
