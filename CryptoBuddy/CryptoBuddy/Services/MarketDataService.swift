//
//  MarketDataService.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 13.01.2023.
//

import Foundation
import Combine

class MarketDataSevice {
    
    @Published var marketData: MarketDataModel? = nil
    
    private var marketDataSubscription: AnyCancellable?
    
    init() {
        
        getData()
    }
    
    func getData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
