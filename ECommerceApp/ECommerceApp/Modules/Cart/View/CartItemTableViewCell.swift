//
//  CartItemTableViewCell.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 22.12.24.
//

import UIKit

final class CartItemTableViewCell: UITableViewCell {
    static let identifier = "CartItemTableViewCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = .MainColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.backgroundColor = .MainColor
        label.textColor = .white
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let decrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGray3
        button.tintColor = .black
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGray3
        button.tintColor = .black
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var onQuantityChanged: ((Int) -> Void)?
    private var quantity: Int = 1

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(decrementButton)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(incrementButton)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: decrementButton.leadingAnchor, constant: -8),

            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            decrementButton.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: -8),
            decrementButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            decrementButton.widthAnchor.constraint(equalToConstant: 40),
            decrementButton.heightAnchor.constraint(equalToConstant: 40),

            quantityLabel.centerYAnchor.constraint(equalTo: decrementButton.centerYAnchor),
            quantityLabel.trailingAnchor.constraint(equalTo: incrementButton.leadingAnchor, constant: -8),
            quantityLabel.widthAnchor.constraint(equalToConstant: 40),
            quantityLabel.heightAnchor.constraint(equalToConstant: 40),

            incrementButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            incrementButton.centerYAnchor.constraint(equalTo: decrementButton.centerYAnchor),
            incrementButton.widthAnchor.constraint(equalToConstant: 40),
            incrementButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        decrementButton.addTarget(self, action: #selector(didTapDecrement), for: .touchUpInside)
        incrementButton.addTarget(self, action: #selector(didTapIncrement), for: .touchUpInside)
    }

    @objc private func didTapDecrement() {
        if quantity > 1 {
            quantity -= 1
            updateQuantityLabel()
            onQuantityChanged?(quantity)
        }
    }

    @objc private func didTapIncrement() {
        quantity += 1
        updateQuantityLabel()
        onQuantityChanged?(quantity)
    }

    private func updateQuantityLabel() {
        quantityLabel.text = "\(quantity)"
    }

    func configure(with item: CartItem, onQuantityChanged: @escaping (Int) -> Void) {
        nameLabel.text = item.name
        priceLabel.text = "\(item.price)₺"
        quantity = item.numberOfCart.toInt()
        updateQuantityLabel()
        self.onQuantityChanged = onQuantityChanged
    }
}

