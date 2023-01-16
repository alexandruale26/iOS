//
//  UIApplication.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 11.01.2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
