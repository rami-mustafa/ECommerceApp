//
//  FilterViewController.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 21.12.24.
//

import UIKit

protocol FilterViewControllerDelegate: AnyObject {
    func didApplyFilters(sortOption: String?, selectedBrands: [String], selectedModels: [String])
}

class FilterViewController: UIViewController {

    weak var delegate: FilterViewControllerDelegate?

    private let viewModel = FilterViewModel()
    private let closeButton = UIButton()
    private let applyButton = UIButton()
    private let brandSearchBar = UISearchBar()
    private let modelSearchBar = UISearchBar()
    private var brandTableView = UITableView()
    private var modelTableView = UITableView()
 
    let oldToNewButton = FilterOptionButton()
    let newToOldButton = FilterOptionButton()
    let priceHighToLowButton = FilterOptionButton()
    let priceLowToHighButton = FilterOptionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
 
    }
    private func setupViews(){
        
        let titleLabel = UILabel()
        titleLabel.text = "Filter"
        titleLabel.font = UIFont(name: "Montserrat-Regular", size: 25)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Close Button
        let closeImage = UIImage(systemName: "xmark")
        closeButton.setImage(closeImage, for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Top Divider
        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        view.addSubview(topDivider)
        topDivider.translatesAutoresizingMaskIntoConstraints = false
        
        oldToNewButton.title = "Old to new"
        newToOldButton.title = "New to old"
        priceHighToLowButton.title = "Price high to low"
        priceLowToHighButton.title = "Price low to high"
        
        view.addSubview(oldToNewButton)
        view.addSubview(newToOldButton)
        view.addSubview(priceHighToLowButton)
        view.addSubview(priceLowToHighButton)

        // Example Constraints for Buttons
        oldToNewButton.translatesAutoresizingMaskIntoConstraints = false
        newToOldButton.translatesAutoresizingMaskIntoConstraints = false
        priceHighToLowButton.translatesAutoresizingMaskIntoConstraints = false
        priceLowToHighButton.translatesAutoresizingMaskIntoConstraints = false

        brandSearchBar.placeholder = "Search Brands"
        brandSearchBar.delegate = self
        brandSearchBar.backgroundImage = UIImage()
        view.addSubview(brandSearchBar)
        brandSearchBar.translatesAutoresizingMaskIntoConstraints = false

        // Middle Divider
        let middleDivider = UIView()
        middleDivider.backgroundColor = .lightGray
        view.addSubview(middleDivider)
        middleDivider.translatesAutoresizingMaskIntoConstraints = false
        
        modelSearchBar.placeholder = "Search Models"
        modelSearchBar.delegate = self
        modelSearchBar.backgroundImage = UIImage()
        view.addSubview(modelSearchBar)
        modelSearchBar.translatesAutoresizingMaskIntoConstraints = false

        brandTableView.delegate = self
        brandTableView.dataSource = self
        brandTableView.register(FilterTableViewCell.self, forCellReuseIdentifier: "FilterTableViewCell")
        brandTableView.separatorStyle = .none
         view.addSubview(brandTableView)
        brandTableView.translatesAutoresizingMaskIntoConstraints = false

        modelTableView.delegate = self
        modelTableView.dataSource = self
        modelTableView.register(FilterTableViewCell.self, forCellReuseIdentifier: "FilterTableViewCell")
        modelTableView.separatorStyle = .none
        view.addSubview(modelTableView)
        modelTableView.translatesAutoresizingMaskIntoConstraints = false
    
        applyButton.setTitle("Primary", for: .normal)
        applyButton.backgroundColor = .MainColor
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.layer.cornerRadius = 8
        applyButton.addTarget(self, action: #selector(didTapApply), for: .touchUpInside)
        view.addSubview(applyButton)
        applyButton.translatesAutoresizingMaskIntoConstraints = false

        
        
        // Constraints
        NSLayoutConstraint.activate([
            // Title Label Constraints
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Close Button Constraints
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            closeButton.widthAnchor.constraint(equalToConstant: 35),
            closeButton.heightAnchor.constraint(equalToConstant: 35),
            
            // Top Divider Constraints
            topDivider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            topDivider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topDivider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topDivider.heightAnchor.constraint(equalToConstant: 1),
            
            oldToNewButton.topAnchor.constraint(equalTo: topDivider.bottomAnchor, constant: 10),
            oldToNewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            oldToNewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            oldToNewButton.heightAnchor.constraint(equalToConstant: 24),
            
            newToOldButton.topAnchor.constraint(equalTo: oldToNewButton.bottomAnchor, constant: 10),
            newToOldButton.leadingAnchor.constraint(equalTo: oldToNewButton.leadingAnchor),
            newToOldButton.trailingAnchor.constraint(equalTo: oldToNewButton.trailingAnchor),
            newToOldButton.heightAnchor.constraint(equalTo: oldToNewButton.heightAnchor),
            
            priceHighToLowButton.topAnchor.constraint(equalTo: newToOldButton.bottomAnchor, constant: 10),
            priceHighToLowButton.leadingAnchor.constraint(equalTo: newToOldButton.leadingAnchor),
            priceHighToLowButton.trailingAnchor.constraint(equalTo: newToOldButton.trailingAnchor),
            priceHighToLowButton.heightAnchor.constraint(equalTo: newToOldButton.heightAnchor),
            
            priceLowToHighButton.topAnchor.constraint(equalTo: priceHighToLowButton.bottomAnchor, constant: 10),
            priceLowToHighButton.leadingAnchor.constraint(equalTo: priceHighToLowButton.leadingAnchor),
            priceLowToHighButton.trailingAnchor.constraint(equalTo: priceHighToLowButton.trailingAnchor),
            priceLowToHighButton.heightAnchor.constraint(equalTo: priceHighToLowButton.heightAnchor),
            
            
            // Brand Search Bar Constraints
            brandSearchBar.topAnchor.constraint(equalTo: priceLowToHighButton.bottomAnchor, constant: 10),
            brandSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            brandSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            brandSearchBar.heightAnchor.constraint(equalToConstant: 44),
            
            // Brand Table View Constraints
            brandTableView.topAnchor.constraint(equalTo: brandSearchBar.bottomAnchor, constant: 10),
            brandTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            brandTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            brandTableView.heightAnchor.constraint(equalToConstant: 200),
            
            // Middle Divider Constraints
            middleDivider.topAnchor.constraint(equalTo: brandTableView.bottomAnchor, constant: 10),
            middleDivider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            middleDivider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            middleDivider.heightAnchor.constraint(equalToConstant: 1),
            
            // Model Search Bar Constraints
            modelSearchBar.topAnchor.constraint(equalTo: middleDivider.bottomAnchor, constant: 10),
            modelSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            modelSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            modelSearchBar.heightAnchor.constraint(equalToConstant: 44),
            
            
            applyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            applyButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Model Table View Constraints
            modelTableView.topAnchor.constraint(equalTo: modelSearchBar.bottomAnchor, constant: 10),
            modelTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            modelTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            modelTableView.bottomAnchor.constraint(equalTo: applyButton.topAnchor, constant: -16)
        ])
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    @objc func didTapApply() {
        
        if let selectedButton = FilterOptionButton.allButtons.first(where: { $0.isSelected }) {
            FilterManager.shared.selectedSortOption = selectedButton.title
        } else {
            FilterManager.shared.selectedSortOption = ""  
        }

        // Save selected brands
        FilterManager.shared.selectedBrands = getSelectedItems(from: brandTableView, type: .brand)

        // Save selected models
        FilterManager.shared.selectedModels = getSelectedItems(from: modelTableView, type: .model)

        print("Selected Sort Option: \(FilterManager.shared.selectedSortOption ?? "None")")
        print("Selected Brands: \(FilterManager.shared.selectedBrands)")
        print("Selected Models: \(FilterManager.shared.selectedModels)")

        delegate?.didApplyFilters(
             sortOption: FilterManager.shared.selectedSortOption,
             selectedBrands: FilterManager.shared.selectedBrands,
             selectedModels: FilterManager.shared.selectedModels
         )
        
        dismiss(animated: true, completion: nil)
    }
    
    private func getSelectedItems(from tableView: UITableView, type: FilterType) -> [String] {
        var selectedItems: [String] = []
        let numberOfRows = tableView == brandTableView ? viewModel.brandCount : viewModel.modelCount

        for row in 0..<numberOfRows {
            let indexPath = IndexPath(row: row, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? FilterTableViewCell, cell.isChecked {
                if type == .brand {
                    selectedItems.append(viewModel.brand(at: row))
                } else if type == .model {
                    selectedItems.append(viewModel.model(at: row))
                }
            }
        }
        return selectedItems
    }
}
 


extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == brandTableView ? viewModel.brandCount : viewModel.modelCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as? FilterTableViewCell else {
            return UITableViewCell()
        }
        
        if tableView == brandTableView {
            cell.configure(with: viewModel.brand(at: indexPath.row), isChecked: false)
        } else {
            cell.configure(with: viewModel.model(at: indexPath.row), isChecked: false)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FilterViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar == brandSearchBar {
            viewModel.filterBrands(with: searchText)
            brandTableView.reloadData()
        } else if searchBar == modelSearchBar {
            viewModel.filterModels(with: searchText)
            modelTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        if searchBar == brandSearchBar {
            viewModel.filterBrands(with: "")
            brandTableView.reloadData()
        } else if searchBar == modelSearchBar {
            viewModel.filterModels(with: "")
            modelTableView.reloadData()
        }
    }
}
