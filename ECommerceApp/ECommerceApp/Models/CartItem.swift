//
//  CartItem.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 17.12.24.
//

import Foundation

import Foundation

struct CartItem: Codable, Hashable {
    let product: Product
    var quantity: Int = 1
    
    // Computed Property: Toplam fiyat
    var totalPrice: String {
        guard let priceValue = Double(product.price ?? "0.00") else { return "0.00" }
        return String(format: "%.2f", priceValue * Double(quantity))
    }
    
    // Hashable Conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(product.id)
    }
    
    // Equatable Conformance
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.product.id == rhs.product.id
    }
}

