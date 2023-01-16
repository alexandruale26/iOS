//
//  SearchBarView.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 11.01.2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var isEmpty: Bool {
        searchText.isEmpty
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .autocorrectionDisabled(true)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.theme.accent)
                        .padding()
                        .offset(x: 10)
                        .opacity(isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                            UIApplication.shared.endEditing()
                        }
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("bitcoin"))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
