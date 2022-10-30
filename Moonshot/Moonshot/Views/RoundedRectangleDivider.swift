//
//  RoundedRectangleDivider.swift
//  Moonshot
//
//  Created by Alexandru Tenie on 29.10.2022.
//

import SwiftUI

struct RoundedRectangleDivider: View {
    let height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .frame(height: height)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct RoundedRectangleDivider_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleDivider(height: 8)
    }
}
