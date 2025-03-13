//
//  UserListViewModel.swift
//  sevenapps-case
//
//  Created by Taha Tuna on 13.03.2025.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorMessage: String = ""
    @Published var isShowingAlert: Bool = false
    @Published var isLoadingUsers: Bool = false
    
    private let userRepository = UserRepository()
    
    init() {
        fetchUsers()
    }
    
    // Fetch Users
    func fetchUsers() {
        
        DispatchQueue.main.async { [weak self] in
            self?.isLoadingUsers = true
        }
        
        userRepository.fetchUsers { [weak self] result in
            // Update UI on the main thread
            DispatchQueue.main.async { [weak self] in
                guard let self else { return } // Prevents memory leaks
                switch result {
                case .success(let users):
                    self.users = users
                    self.isLoadingUsers = false
                case .failure(let error):
                    self.isLoadingUsers = false
                    self.errorMessage = "Failed to load users: \(error.localizedDescription)"
                    self.isShowingAlert = true
                }
            }
        }
    }
}
