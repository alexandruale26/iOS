//
//  XMarkButton.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 13.01.2023.
//

import SwiftUI

struct XMarkButton: View {
    let dismissAction: DismissAction
    
    var body: some View {
        
        Button {
            dismissAction()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

struct XMarkButton_Previews: PreviewProvider {
    @Environment(\.dismiss) static private var dismiss
    static var previews: some View {
        XMarkButton(dismissAction: dismiss)
    }
}
