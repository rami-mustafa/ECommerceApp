//
//  ProductsViewModel.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 18.12.24.
//

import Foundation

protocol ProductsViewModelProtocol: AnyObject {
    func viewDidLoad()
    var itemsCount: Int { get }
    var onDataUpdated: (() -> Void)? { get set }
    func item(at index: Int) -> Product
    func searchBarFilterData(searchText: String)
    
}


final class ProductsViewModel {
    private var products: [Product] = [] {
        didSet {
            filteredProducts = products
        }
    }
    
    private(set) var filteredProducts: [Product] = [] {
        didSet {
            onDataUpdated?()
        }
    }
    
    private let networkManager = NetworkManager.shared
    
    var itemsCount: Int {
        filteredProducts.count
    }
    

    var onDataUpdated: (() -> Void)?
    
    func fetchProducts() {
        Task {
            do {
                self.products = try await NetworkManager.shared.fetchProducts()
                self.applyFilters()
            } catch let error as NetworkError {
                print("Network Error: \(error.localizedDescription)")
            } catch {
                print("Unexpected Error: \(error.localizedDescription)")
            }
        }
    }
    

    
    private func performFilter(searchText: String) {
        let searchFiltered = searchText.isEmpty ? products : products.filter {
            $0.safeName.lowercased().contains(searchText.lowercased())
        }
        filteredProducts = applySortAndFilters(to: searchFiltered)
    }

    private func applySortAndFilters(to products: [Product]) -> [Product] {
        var filtered = products

        // Apply brand filter
        if !FilterManager.shared.selectedBrands.isEmpty {
            filtered = filtered.filter { product in
                if let brand = product.brand {
                    return FilterManager.shared.selectedBrands.contains(brand)
                }
                return false
            }
        }

        // Apply model filter
        if !FilterManager.shared.selectedModels.isEmpty {
            filtered = filtered.filter { product in
                if let model = product.model {
                    return FilterManager.shared.selectedModels.contains(model)
                }
                return false
            }
        }

        // Apply sort option
        switch FilterManager.shared.selectedSortOption {
        case "Old to new":
            filtered.sort { $0.createdAt ?? "" < $1.createdAt ?? "" }
        case "New to old":
            filtered.sort { $0.createdAt ?? "" > $1.createdAt ?? "" }
        case "Price high to low":
            filtered.sort { Double($0.safePrice) ?? 0 > Double($1.safePrice) ?? 0 }
        case "Price low to high":
            filtered.sort { Double($0.safePrice) ?? 0 < Double($1.safePrice) ?? 0 }
        default:
            break
        }

        return filtered
    }

    func applyFilters() {
        filteredProducts = applySortAndFilters(to: products)
    }
    
    func item(at index: Int) -> Product {
        guard index >= 0 && index < filteredProducts.count else {
            fatalError("Index out of bounds")
        }
        return filteredProducts[index]
    }
}

extension ProductsViewModel: ProductsViewModelProtocol {
    func viewDidLoad() {
        fetchProducts()
    }
    
    func searchBarFilterData(searchText: String) {
        performFilter(searchText: searchText) // Call the renamed private method
    }
}
