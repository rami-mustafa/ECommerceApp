//
//  ProductsViewController.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 18.12.24.
//

import UIKit

final class ProductsViewController: BaseViewController {
  
    private let viewModel = ProductsViewModel()
    private let searchBar = UISearchBar()
    private let filtersLabel = UILabel()
    private let filterButton = UIButton()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 21
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad()
        bindViewModel()

    }

    private func setupUI() {
        
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        filterButton.setTitle("Select Filter", for: .normal)
        filterButton.setTitleColor(.black, for: .normal)
        filterButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        filterButton.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        filterButton.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)
        view.addSubview(filterButton)
        filterButton.translatesAutoresizingMaskIntoConstraints = false


        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCollectionViewCell")
        view.addSubview(collectionView)
      
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 14),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            filterButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 14),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            filterButton.widthAnchor.constraint(equalToConstant: 158),
            filterButton.heightAnchor.constraint(equalToConstant: 36),

            collectionView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 14),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            self?.reloadData()
        }
    }

    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    @objc func didTapFilter() {
        let filterVC = FilterViewController()
        filterVC.modalPresentationStyle = .fullScreen
        filterVC.delegate = self
        present(filterVC, animated: true, completion: nil)
    }
}

extension ProductsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchBarFilterData(searchText: searchText)
    }
}


extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemsCount 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        let product = viewModel.item(at: indexPath.row)  
        cell.configure(with: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.item(at: indexPath.row)
        let detailViewModel = ProductDetailViewModel(product: product)
        let detailVC = ProductDetailViewController(viewModel: detailViewModel)
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = 15 + 15 + 21 // Sağ, sol padding ve hücre arası boşluk
        let availableWidth = view.frame.size.width - CGFloat(totalSpacing)
        let cellWidth = availableWidth / 2
        return CGSize(width: cellWidth, height: 300)
    }
}

extension ProductsViewController: FilterViewControllerDelegate {
    func didApplyFilters(sortOption: String?, selectedBrands: [String], selectedModels: [String]) {
        print("Sort Option: \(sortOption ?? "None")")
        print("Selected Brands: \(selectedBrands)")
        print("Selected Models: \(selectedModels)")

        // Apply filters to the view model
        FilterManager.shared.selectedSortOption = sortOption
        FilterManager.shared.selectedBrands = selectedBrands
        FilterManager.shared.selectedModels = selectedModels
        viewModel.applyFilters()
    }
}
