//
//  UITableViewCell.swift
//  sevenapps-case
//
//  Created by Taha Tuna on 13.03.2025.
//

import Foundation
import UIKit

// MARK: - UIKit Table View Cell
// TODO: - Change the bg color to gray, add rounded corners and adjustments to make it look better
class UserTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            nameLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -5),
            
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            emailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])

        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        emailLabel.font = UIFont.systemFont(ofSize: 12)
        emailLabel.textColor = .gray
    }
}
