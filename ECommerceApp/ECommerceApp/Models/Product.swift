//
//  Product.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 17.12.24.
//

 import Foundation

struct Product: Codable, Hashable {
    let createdAt: String?
    let name: String?
    let image: String?
    let price: String?
    let description: String?
    let model: String?
    let brand: String?
    let id: String?
    var numberOfCart: Int? = 0
    // Safe Accessors
    var safeName: String {
        return name ?? "Unknown Product"
    }

    var safePrice: String {
        return price ?? "0.00"
    }
    
    // Hashable Conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Equatable Conformance
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
