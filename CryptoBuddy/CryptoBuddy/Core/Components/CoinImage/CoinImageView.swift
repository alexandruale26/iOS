//
//  CoinImageView.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 11.01.2023.
//

import SwiftUI


struct CoinImageView: View {
    
    @StateObject private var vm: CoinImageViewModel
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
    
    init(coin: CoinModel) {
        
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
