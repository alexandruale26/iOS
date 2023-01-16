//
//  HomeView.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 10.01.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    @State private var showSettingsView: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            
            VStack {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                columnTitles
                
                if !showPortfolio {
                    allCoinsList.transition(.move(edge: .leading))
                } else {
                    portfolioCoinsList.transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
        }
        .background(
            NavigationLink("Destination", destination: DetailLoadingView(coin: $selectedCoin), isActive: $showDetailView)
        )
    }
}

extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView = true
                    } else {
                        showSettingsView = true
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none, value: showPortfolio)
            
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                    
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            
            HStack(spacing: 4) {
                Text("Price")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button {
                withAnimation(.linear(duration: 0.5)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
                    .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0.0), anchor: .center)
            }
            
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    private func segue(coin: CoinModel) {
        
        selectedCoin = coin
        showDetailView.toggle()
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            HomeView()
                .toolbar(.hidden)
        }
        .preferredColorScheme(.dark)
        .environmentObject(dev.homeVM)
    }
}
