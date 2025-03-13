//
//  SwifUIListView.swift
//  sevenapps-case
//
//  Created by Taha Tuna on 13.03.2025.
//

import SwiftUI

struct SwiftUIListView: View {
    
    @StateObject private var viewModel = UserListViewModel()
    let noUserIcon: String = "person.crop.circle.badge.exclamationmark"
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.users.isEmpty {
                    emptyStateView
                } else {
                    userListView
                }
            }
            .navigationTitle("Users")
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.isShowingAlert) {
            Button("Try Again", role: .cancel) {
                viewModel.fetchUsers()
            }
        }
    }
    
    private var emptyStateView: some View {
        Group {
            if viewModel.isLoadingUsers {
                ProgressView()
                    .tint(.red.opacity(0.8))
            } else {
                noUsersView
            }
        }
    }
    
    @ViewBuilder
    private var noUsersView: some View {
        // ContentUnavailableView is iOS 17 and up
        if #available(iOS 17, *) {
            ContentUnavailableView("No Users", systemImage: noUserIcon)
        } else {
            // Replicate the ContentUnavailableView look
            VStack(spacing: 10) {
                Image(systemName: noUserIcon)
                    .font(.largeTitle)
                Text("No Users")
                    .font(.headline)
            }
            .padding()
            .foregroundStyle(.gray)
        }
    }
    
    private var userListView: some View {
        List {
            ForEach(viewModel.users) { user in
                
                // Navigate to the Detail View
                NavigationLink(destination: UserDetailView(user: user)) {
                    // consider refactoring?
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            } // Swipe Delete function
            .onDelete { indexSet in
                viewModel.users.remove(atOffsets: indexSet)
            }
        }
    }
}



#Preview {
    SwiftUIListView()
}
