//
//  CircleButtonAnimationView.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 10.01.2023.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 5.0)
            .scaleEffect(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation( animate ? .easeOut(duration: 1.0) : .none, value: animate)
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(false))
            .frame(width: 100, height: 100)
            .foregroundColor(.red)
    }
}
