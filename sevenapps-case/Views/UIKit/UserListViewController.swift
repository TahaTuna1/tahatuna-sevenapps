//
//  UserListViewController.swift
//  sevenapps-case
//
//  Created by Taha Tuna on 13.03.2025.
//

import Foundation
import UIKit

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var tableView = UITableView()
    
    // SF Symbol of a dude
    private let noUserIcon: String = "person.crop.circle.badge.exclamationmark"
    var viewModel: UserListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        navigationItem.title = "Users"
        setupTableView()
        reloadData()
        viewModel.fetchUsers()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColor.clear
        tableView.layer.cornerRadius = 12
        tableView.layer.masksToBounds = true
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func reloadData() {
        viewModel.fetchUsers()
        tableView.reloadData()
        if viewModel.isShowingAlert {
            presentAlert()
        }
    }
    
    // Present alert if we fail fetching
    private func presentAlert() {
        let alert = UIAlertController(title: "Error", message: viewModel.errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default) { _ in
            self.reloadData()
        })
        present(alert, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.isEmpty ? 1 : viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Use subtitle style for the cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UserCell")
        cell.textLabel?.numberOfLines = 1
        cell.detailTextLabel?.numberOfLines = 1
        
        // If we don't have users, replicate the "ContentUnavailableView"
        if viewModel.users.isEmpty {
            cell.imageView?.image = UIImage(systemName: noUserIcon)
            cell.textLabel?.text = "No Users"
            cell.textLabel?.textColor = .gray
            cell.accessoryType = .none
        } else {
            let user = viewModel.users[indexPath.row]
            cell.textLabel?.text = user.name
            cell.detailTextLabel?.text = user.email
            
            cell.textLabel?.textColor = .label
            cell.textLabel?.font = .boldSystemFont(ofSize: 14)
            cell.detailTextLabel?.textColor = .gray
            cell.detailTextLabel?.font = .systemFont(ofSize: 10)
            cell.backgroundColor = .white
            cell.accessoryType = .disclosureIndicator
            
            // Set rounded corners and separator insets
            cell.contentView.layer.cornerRadius = 8
            cell.contentView.layer.masksToBounds = true
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if !viewModel.users.isEmpty {
            let selectedUser = viewModel.users[indexPath.row]
            let detailVC = UserDetailViewController(user: selectedUser)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    // Swipe to delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return !viewModel.users.isEmpty
    }
}
