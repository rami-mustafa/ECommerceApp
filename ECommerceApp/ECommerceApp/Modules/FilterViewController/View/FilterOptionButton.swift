//
//  FilterOptionButton.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 21.12.24.
//

import UIKit

import UIKit

class FilterOptionButton: UIButton {
    
    static var allButtons = [FilterOptionButton]()
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    private let circleSize: CGFloat = 23.0
    private let circleView = UIView()
    private let dotView = UIView()
    
    var title: String = "" {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    init() {
        super.init(frame: .zero)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setupUI()
        FilterOptionButton.allButtons.append(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Title Configuration
        titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 15)
        setTitleColor(.black, for: .normal)
        contentHorizontalAlignment = .left
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 19)
        
        // Circle View
        circleView.layer.borderColor = UIColor.systemBlue.cgColor
        circleView.layer.borderWidth = 1
        circleView.layer.cornerRadius = circleSize / 2
        circleView.isHidden = false
        addSubview(circleView)
        
        // Dot View
        dotView.backgroundColor = .clear
        dotView.layer.cornerRadius = (circleSize - 8) / 2
        circleView.addSubview(dotView)
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        dotView.translatesAutoresizingMaskIntoConstraints = false
        
        // Circle View Constraints
        NSLayoutConstraint.activate([
            circleView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            circleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            circleView.widthAnchor.constraint(equalToConstant: circleSize),
            circleView.heightAnchor.constraint(equalToConstant: circleSize)
        ])
        
        // Dot View Constraints
        NSLayoutConstraint.activate([
            dotView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            dotView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            dotView.widthAnchor.constraint(equalToConstant: circleSize - 8),
            dotView.heightAnchor.constraint(equalToConstant: circleSize - 8)
        ])
        
      }
    
 
    private func updateAppearance() {
        if isSelected {
            dotView.backgroundColor = .systemBlue
        } else {
            dotView.backgroundColor = .clear
        }
    }
    
    @objc private func buttonTapped() {
        // Deselect all buttons
        FilterOptionButton.allButtons.forEach { $0.isSelected = false }
        // Select current button
        isSelected = true
    }
}

