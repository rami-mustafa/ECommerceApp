//
//  ProductCollectionViewCell.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 21.12.24.
//

import UIKit
import Kingfisher

final class ProductCollectionViewCell: UICollectionViewCell {
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.backgroundColor = .lightGray // Default background color
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = .systemGreen
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "favorite_empty"), for: .normal)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        
        contentView.backgroundColor = UIColor.white
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.5

        contentView.addSubview(productImageView)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(priceLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(addToCartButton)

        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            // Product Image
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            productImageView.heightAnchor.constraint(equalToConstant: 150),

            // Activity Indicator
            activityIndicator.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor),

            // Favorite Button
            favoriteButton.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24),

            // Price Label
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 15),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            priceLabel.heightAnchor.constraint(equalToConstant: 17),


            // Name Label
            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 34),

            // Add to Cart Button
            addToCartButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            addToCartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addToCartButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    func configure(with product: Product) {
        nameLabel.text = product.safeName
        priceLabel.text = product.safePrice

        // Reset image
        productImageView.image = nil
        activityIndicator.startAnimating()

        // Load image
        if let imageUrl = product.image, let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.productImageView.image = image
                        self.activityIndicator.stopAnimating()
                    }
                } else {
                    DispatchQueue.main.async {
                          self.productImageView.image = UIImage(systemName: "photo") // System image kullanımı
                          self.productImageView.contentMode = .scaleAspectFit
                          self.productImageView.tintColor = .lightGray
                          self.activityIndicator.stopAnimating()
                      }
                }
            }
        } else {
            productImageView.image = UIImage(systemName: "photo") // System image kullanımı
            productImageView.contentMode = .scaleAspectFit
            productImageView.tintColor = .lightGray
            activityIndicator.stopAnimating()
        }

        // Favorite Button State
        favoriteButton.setImage(UIImage(named: "favorite_empty"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
    }

    @objc private func toggleFavorite() {
        let isFavorite = favoriteButton.image(for: .normal) == UIImage(named: "favorite_empty")
        let newImageName = isFavorite ? "favorite_filled" : "favorite_empty"
        favoriteButton.setImage(UIImage(named: newImageName), for: .normal)
    }
}

