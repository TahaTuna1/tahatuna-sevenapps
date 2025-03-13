//
//  Haptics.swift
//  sevenapps-case
//
//  Created by Taha Tuna on 13.03.2025.
//

import Foundation
import SwiftUI

// Singleton Haptic Generator
final class HapticController {
    static let shared = HapticController()
    
    private var generator: UIImpactFeedbackGenerator?
    private var currentStyle: UIImpactFeedbackGenerator.FeedbackStyle?
    private var isCooldownActive = false
    private let cooldownDuration: TimeInterval = 0.1 // 100 milliseconds
    
    private init() {
        prepareHaptic(of: .rigid)
    }
    
    func prepareHaptic(of style: UIImpactFeedbackGenerator.FeedbackStyle) {
        if currentStyle != style {
            generator = UIImpactFeedbackGenerator(style: style)
            generator?.prepare()
            currentStyle = style
        }
    }
    
    func triggerHaptic(of style: UIImpactFeedbackGenerator.FeedbackStyle = .rigid) { // rigid style
        guard !isCooldownActive else { return }
        
        prepareHaptic(of: style)
        generator?.impactOccurred()
        
        isCooldownActive = true
        DispatchQueue.main.asyncAfter(deadline: .now() + cooldownDuration) {
            self.isCooldownActive = false
        }
    }
}
