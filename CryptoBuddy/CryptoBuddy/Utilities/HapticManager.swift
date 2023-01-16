//
//  HapticManager.swift
//  CryptoBuddy
//
//  Created by Alexandru Tenie on 13.01.2023.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
        
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        
        generator.notificationOccurred(type)
    }
}
