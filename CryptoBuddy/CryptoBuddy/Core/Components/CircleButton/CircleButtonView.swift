//
//  CircleButtonView.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 10.01.2023.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(Circle() .foregroundColor(Color.theme.background))
            .shadow(color: Color.theme.accent.opacity(0.5), radius: 10)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "minus")
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
