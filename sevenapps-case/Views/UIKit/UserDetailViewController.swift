//
//  UserDetailViewController.swift
//  sevenapps-case
//
//  Created by Taha Tuna on 13.03.2025.
//

import Foundation
import UIKit

// MARK: - UIKit User Detail VC
class UserDetailViewController: UIViewController {
    private let user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUI()
    }
    
    private func setupView() {
        // Same bg color as the default SwiftUI List
        view.backgroundColor = .systemGray6
        
        // Name, but this time it is in a different navigation title display style
        title = user.name
    }
    
    private func setupUI() {
        let scrollView = createScrollView()
        let contentView = createContentView()
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate(ScrollableViewConstraints(view: view, scrollView: scrollView, contentView: contentView))
        
        let stackView = createStackView()
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate(StackViewConstraints(contentView: contentView, stackView: stackView))
        
        addSections(to: stackView)
    }
    
    // Scrollview will not scroll if there's enough space. If "sections" array has more items, it will scroll
    private func createScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
    
    private func createContentView() -> UIView {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func addSections(to stackView: UIStackView) {
        let sections = [
            ("Contact Info", ["Email: \(user.email)", "Phone: \(user.phone)", "Website: \(user.website)"]),
            ("Address", ["\(user.address.street), \(user.address.suite)", "\(user.address.city), \(user.address.zipcode)"]),
            ("Company", [user.company.name, "Catchphrase: \(user.company.catchPhrase)", "BS: \(user.company.bs)"])
        ]
        
        for section in sections {
            stackView.addArrangedSubview(createSection(title: section.0, contents: section.1))
        }
    }
    
    // Create the Contact info, address, and company sections
    private func createSection(title: String, contents: [String]) -> UIView {
        let container = createContainer()
        let titleLabel = createTitleLabel(with: title)
        container.addArrangedSubview(titleLabel)
        
        let sectionView = createSectionView()
        container.addArrangedSubview(sectionView)
        
        let sectionStackView = createSectionStackView()
        sectionView.addSubview(sectionStackView)
        
        NSLayoutConstraint.activate(SectionStackViewConstraints(sectionView: sectionView, sectionStackView: sectionStackView))
        
        addContents(contents, to: sectionStackView)
        
        return container
    }
    
    private func createContainer() -> UIStackView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 8
        container.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        container.isLayoutMarginsRelativeArrangement = true
        return container
    }
    
    private func createTitleLabel(with title: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 12, weight: .light)
        titleLabel.textAlignment = .left
        return titleLabel
    }
    
    private func createSectionView() -> UIView {
        let sectionView = UIView()
        sectionView.backgroundColor = .white
        sectionView.layer.cornerRadius = 20
        sectionView.layer.masksToBounds = true
        sectionView.translatesAutoresizingMaskIntoConstraints = false
        return sectionView
    }
    
    private func createSectionStackView() -> UIStackView {
        let sectionStackView = UIStackView()
        sectionStackView.axis = .vertical
        sectionStackView.spacing = 12
        sectionStackView.translatesAutoresizingMaskIntoConstraints = false
        return sectionStackView
    }
    
    private func addContents(_ contents: [String], to stackView: UIStackView) {
        for (index, text) in contents.enumerated() {
            if index > 0 {
                let separator = createSeparator()
                stackView.addArrangedSubview(separator)
            }
            
            let label = createContentLabel(with: text)
            stackView.addArrangedSubview(label)
        }
    }
    
    // Separator to make it look more like the SwiftUI version
    private func createSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .separator
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return separator
    }
    
    private func createContentLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }
}

// Constraints Extension to keep things organized
extension UserDetailViewController {
    func ScrollableViewConstraints(view: UIView, scrollView: UIScrollView, contentView: UIView) -> [NSLayoutConstraint] {
        return [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
    }
    
    func StackViewConstraints(contentView: UIView, stackView: UIStackView) -> [NSLayoutConstraint] {
        return [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
    }
    
    func SectionStackViewConstraints(sectionView: UIView, sectionStackView: UIStackView) -> [NSLayoutConstraint] {
        return [
            sectionStackView.topAnchor.constraint(equalTo: sectionView.topAnchor, constant: 16),
            sectionStackView.bottomAnchor.constraint(equalTo: sectionView.bottomAnchor, constant: -16),
            sectionStackView.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 16),
            sectionStackView.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -16)
        ]
    }
}
