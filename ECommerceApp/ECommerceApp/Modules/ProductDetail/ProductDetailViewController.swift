//
//  ProductDetailViewController.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 22.12.24.
//

import UIKit

final class ProductDetailViewController: UIViewController {
    
    private let viewModel: ProductDetailViewModel
    private let headerView = UIView()
    private let headlineLabel = UILabel()

    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 24)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 20)
        label.textColor = .MainColor
        label.text = "Price"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Black", size: 17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 18)
        button.backgroundColor = .MainColor
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }

    private func setupUI() {
        view.backgroundColor = .white

        headerView.backgroundColor = .MainColor
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)

        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        headerView.addSubview(backButton)
        
        headlineLabel.textColor = .white
        headlineLabel.font = UIFont(name: "Montserrat-Black", size: 20)
        headlineLabel.textAlignment = .left
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headlineLabel)

        view.addSubview(productImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(priceTitleLabel)
        view.addSubview(priceLabel)
        view.addSubview(addToCartButton)

        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 49),
            
            backButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),

            headlineLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headlineLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20),
            headlineLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            headlineLabel.heightAnchor.constraint(equalToConstant: 29),

            productImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),            
            productImageView.heightAnchor.constraint(equalToConstant: 300),

            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            priceTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceTitleLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -4),

            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addToCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addToCartButton.widthAnchor.constraint(equalToConstant: 170),
            addToCartButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    @objc private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
}

extension ProductDetailViewController: ProductDetailViewDelegate {
    func updateImage(_ imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
            productImageView.image = UIImage(systemName: "photo")
            productImageView.contentMode = .scaleAspectFit
            productImageView.tintColor = .lightGray
            return
        }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.productImageView.image = image
                    self.productImageView.contentMode = .scaleAspectFit
                }
            } else {
                DispatchQueue.main.async {
                    self.productImageView.image = UIImage(systemName: "photo")
                    self.productImageView.contentMode = .scaleAspectFit
                    self.productImageView.tintColor = .lightGray
                }
            }
        }
    }

    func updateTitle(_ title: String) {
        titleLabel.text = title
        headlineLabel.text = title
    }

    func updateDescription(_ description: String) {
        descriptionLabel.text = description
    }

    func updatePrice(_ price: String) {
        priceLabel.text = price.tl
    }
}
