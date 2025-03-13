//
//  UserDetailView.swift
//  sevenapps-case
//
//  Created by Taha Tuna on 13.03.2025.
//

import SwiftUI

// MARK: - User Detail View
struct UserDetailView: View {
    let user: User
    
    var body: some View {
        List {
            Section(header: Text("Contact Info")) {
                Text("Email: \(user.email)")
                Text("Phone: \(user.phone)")
                Text("Website: \(user.website)")
            }
            
            // TODO: - Add a MapView to display user's location
            Section(header: Text("Address")) {
                Text("\(user.address.street), \(user.address.suite)")
                Text("\(user.address.city), \(user.address.zipcode)")
            }
            Section(header: Text("Company")) {
                Text(user.company.name)
                Text("Catchphrase: \(user.company.catchPhrase)")
                Text("BS: \(user.company.bs)")
            }
        }
        .navigationTitle(user.name)
        
        // TODO: - Add an action button
    }
}
