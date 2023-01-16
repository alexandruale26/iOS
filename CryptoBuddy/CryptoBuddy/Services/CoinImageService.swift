//
//  CoinImageService.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 11.01.2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage?
    
    private let coin: CoinModel
    private var imageSubscription: AnyCancellable?
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        
        self.coin = coin
        self.imageName = coin.name
        getCoinImage()
    }
    
    private func getCoinImage() {
        
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            self.image = savedImage
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        
        guard let url = URL(string: self.coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self,
                      let downloadedImage = returnedImage else  { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
