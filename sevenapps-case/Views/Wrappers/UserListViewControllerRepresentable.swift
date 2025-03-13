//
//  UserListViewControllerRepresentable.swift
//  sevenapps-case
//
//  Created by Taha Tuna on 13.03.2025.
//

import Foundation
import UIKit
import SwiftUI


//MARK: - UserListViewController Representable
// Allows us to use UIKit with SwiftUI
struct UserListViewControllerRepresentable: UIViewControllerRepresentable {
    @EnvironmentObject var viewModel: UserListViewModel
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let userListVC = UserListViewController()
        userListVC.viewModel = viewModel
        
        let navigationController = UINavigationController(rootViewController: userListVC)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}
