//
//  ContentView.swift
//  Moonshot
//
//  Created by Alexandru Tenie on 29.10.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showList = false
    
    private let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    private let missions: [Mission] = Bundle.main.decode("missions.json")
    
    private let columns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationView {
            Group {
                if showList {
                    ListLayout(missions: missions, astronauts: astronauts)
                } else {
                    GridLayout(columns: columns, missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    showList.toggle()
                } label: {
                    Text(showList ? "Grid" : "List")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
