//
//  UserRepository.swift
//  sevenapps-case
//
//  Created by Taha Tuna on 13.03.2025.
//

import Foundation

// MARK: - User Repository
// Connects the ViewModel to the NetworkingService
class UserRepository {
    private let networkService = NetworkService.shared
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        networkService.fetchUsers(completion: completion)
    }
}
