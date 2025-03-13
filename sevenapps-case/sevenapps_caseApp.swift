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
    
    var body: some Scene {
        WindowGroup {
            TabView {
                SwiftUIListView()
                    .environmentObject(viewModel)
                    .tabItem {
                        Label("SwiftUI", systemImage: "swift")
                    }
                
                // Representable Wrapper to incorporate UIKit into SwiftUI
                UserListViewControllerRepresentable()
                    .environmentObject(viewModel)
                    .tabItem {
                        Label("UIKit", systemImage: "square.stack.3d.up")
                    }
            }
        }
    }
}
