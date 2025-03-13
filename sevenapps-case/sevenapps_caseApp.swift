//
//  sevenapps_caseApp.swift
//  sevenapps-case
//
//  Created by Taha Tuna on 13.03.2025.
//

import SwiftUI

@main
struct sevenapps_caseApp: App {
    
    // Share the View Model
    @StateObject private var viewModel = UserListViewModel()
    
    // MARK: - SwiftUI and UIKit versions together in a Tabview.
    // The Model, ViewModel and the Networking stuff are shared.
    
    
    @State private var selectedTab = 0
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                SwiftUIListView()
                    .environmentObject(viewModel)
                    .tabItem {
                        Label("SwiftUI", systemImage: "swift")
                    }
                    .tag(0)
                
                // Representable Wrapper to incorporate UIKit into SwiftUI
                UserListViewControllerRepresentable()
                    .environmentObject(viewModel)
                    .tabItem {
                        Label("UIKit", systemImage: "square.stack.3d.up")
                    }
                    .tag(1)
            }
            .onChange(of: selectedTab) { _ in // trigger haptics
                HapticController.shared.triggerHaptic(of: .heavy)
            }
        }
    }
}
