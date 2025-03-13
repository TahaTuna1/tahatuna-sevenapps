//
//  NetworkService.swift
//  sevenapps-case
//
//  Created by Taha Tuna on 13.03.2025.
//

import Foundation

// MARK: - NetworkService
// With URLSession
struct NetworkService {
    static let shared = NetworkService()
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        
        // FIXME: - This is being called twice at first??
        // (for demo)
        print("Fetching users...")
        
        let urlString = "https://jsonplaceholder.typicode.com/users"
        
        guard let url = URL(string: urlString) else {
            return completion(.failure(NetworkError.invalidURL))
        }
        
        // Send the request
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let data = data else {
                return completion(.failure(NetworkError.noData))
            }
            
            do {
                // Decode the data if possible and return the result
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
