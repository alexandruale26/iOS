//
//  DetailView.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 13.01.2023.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    
    private let spacing: CGFloat = 30
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    
                    descriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    
                    additionalGrid
                    websiteSection
                }
                .padding()
            }
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing: \(coin.name)")
    }
}

extension DetailView {
    
    private var overviewTitle: some View {
        
        Text("Overview")
            .font(.title.bold())
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        
        Text("Additional Details")
            .font(.title.bold())
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionSection: some View {
        
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription).lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                        .animation(showFullDescription ? Animation.easeInOut(duration: 0.05) : .none, value: showFullDescription)
                    
                    Button {
                        showFullDescription.toggle()
                    } label: {
                        Text(showFullDescription ? "Less" : "Read More...")
                            .font(.caption.bold())
                            .padding(.vertical, 4)
                    }
                    .tint(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
        }
    }
    
    private var overviewGrid: some View {
        
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    private var additionalGrid: some View {
        
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    private var navigationBarTrailingItems: some View {
        
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var websiteSection: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString) {
                Link("Website", destination: url)
            }
            
            if let redditString = vm.redditURL,
               let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
        }
        .font(.headline)
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        NavigationView {
            DetailView(coin: dev.coin)
                .preferredColorScheme(.dark)
        }
    }
}
