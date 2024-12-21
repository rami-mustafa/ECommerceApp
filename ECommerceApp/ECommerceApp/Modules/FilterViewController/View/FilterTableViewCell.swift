//
//  FilterTableViewCell.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 21.12.24.
//

import UIKit

import UIKit

final class FilterTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private let checkboxButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square"), for: .normal) // Initial empty checkbox
        button.tintColor = .MainColor
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    // MARK: - Properties
    var isChecked: Bool = false {
        didSet {
            let imageName = isChecked ? "checkmark.square.fill" : "square"
            checkboxButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupViews() {
        contentView.addSubview(checkboxButton)
        contentView.addSubview(nameLabel)
        
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Checkbox constraints
            checkboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkboxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkboxButton.widthAnchor.constraint(equalToConstant: 24),
            checkboxButton.heightAnchor.constraint(equalToConstant: 24),
            
            // Name label constraints
            nameLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        // Add action to checkbox button
        checkboxButton.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
    }
    
    // MARK: - Configuration
    func configure(with name: String, isChecked: Bool) {
        nameLabel.text = name
        self.isChecked = isChecked
    }
    
    // MARK: - Actions
    @objc private func toggleCheckbox() {
        isChecked.toggle() // Change the state
    }
}

