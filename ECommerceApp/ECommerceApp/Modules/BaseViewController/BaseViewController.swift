//
//  BaseViewController.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 21.12.24.
//
import UIKit

class BaseViewController: UIViewController {
    
    private let headerContainerView = UIView()
     let mainContentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        // Setup Header View
        headerContainerView.backgroundColor = .MainColor
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerContainerView)

        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerContainerView.heightAnchor.constraint(equalToConstant: 49)
        ])

        let titleLabel = UILabel()
        titleLabel.text = "E-Market"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Montserrat-Black", size: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerContainerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 29),
        ])

        // Setup Main Content View
        mainContentView.backgroundColor = .white // Customize as needed
        mainContentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainContentView)

        NSLayoutConstraint.activate([
            mainContentView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor),
            mainContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
