//
//  CartViewController.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 22.12.24.
//

import UIKit

final class CartViewController: BaseViewController {
    private let viewModel: CartViewModelProtocol = CartViewModel()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CartCell")
        return tableView
    }()

    private let totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 20)
        label.textColor = .MainColor
        label.text = "Total:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("complete", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 18)
        button.backgroundColor = .MainColor
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
        tableView.reloadData()
        updateTotalAmount()
        
        CartManager.shared.resetCartCount()
        tabBarController?.tabBar.items?[1].badgeValue = nil
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(totalLabel)
        view.addSubview(totalTitleLabel)
        view.addSubview(completeButton)
        
        completeButton.addTarget(self, action: #selector(didTapCompleteButton), for: .touchUpInside)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartItemTableViewCell.self, forCellReuseIdentifier: CartItemTableViewCell.identifier)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 14),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: totalLabel.topAnchor),

            totalTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            totalTitleLabel.bottomAnchor.constraint(equalTo: totalLabel.topAnchor, constant: -4),

            totalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            totalLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            completeButton.widthAnchor.constraint(equalToConstant: 170),
            completeButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }

    private func bindViewModel() {
        updateTotalAmount()
    }

    private func updateTotalAmount() {
        totalLabel.text = "\(viewModel.totalCartAmount) ₺"
    }
    @objc private func didTapCompleteButton() {
        
        if CartManager.shared.isCartEmpty() {
            let alert = UIAlertController(
                title: "Cart is Empty",
                message: "Please add items to your cart before completing your order.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let alert = UIAlertController(
            title: "Complete Order",
            message: "Are you sure you want to complete your order? This will clear your cart.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { [weak self] _ in
            CartManager.shared.clearCart()
            self?.viewModel.viewWillAppear()  
            self?.tableView.reloadData()
            self?.updateTotalAmount()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func updateCartBadge() {
        let totalItems = CartManager.shared.totalItemCount()
        if totalItems > 0 {
            tabBarController?.tabBar.items?[1].badgeValue = "\(totalItems)" 
        } else {
            tabBarController?.tabBar.items?[1].badgeValue = nil
        }
    }

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTableViewCell.identifier, for: indexPath) as? CartItemTableViewCell else {
            return UITableViewCell()
        }
        let cartItem = viewModel.item(at: indexPath.row)
        cell.configure(with: cartItem) { [weak self] newQuantity in
            CartManager.shared.updateQuantity(for: cartItem.id ?? "UnknownID", quantity: newQuantity)
            self?.viewModel.viewWillAppear()
            self?.updateTotalAmount()
        }
        cell.selectionStyle = .none 
        return cell
    }
}
