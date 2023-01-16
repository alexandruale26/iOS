//
//  CoinImageViewModel.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 11.01.2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let dataService: CoinImageService
    private var cancellables =  Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        
        self.dataService = CoinImageService(coin: coin)
        addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
    
}
