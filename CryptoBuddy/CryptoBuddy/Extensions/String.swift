//
//  String.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 14.01.2023.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
