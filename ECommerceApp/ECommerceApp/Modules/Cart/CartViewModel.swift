//
//  CartViewModel.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 22.12.24.
//

import Foundation

protocol CartViewModelProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    var itemsCount: Int { get }
    func item(at index: Int) -> CartItem
    var totalCartAmount: Double { get }
}

final class CartViewModel {
    private var cartItems: [CartItem] = [] {
        didSet {
            totalAmount = cartItems.reduce(0) { $0 + ($1.price * Double($1.numberOfCart)) }
        }
    }
    private var totalAmount: Double = 0.0

    private func fetchCartItems() {
        cartItems = CartManager.shared.fetchCartItems()
    }

    private func updateCart() {
        fetchCartItems()
    }
}

extension CartViewModel: CartViewModelProtocol {
    var itemsCount: Int {
        return cartItems.count
    }

    var totalCartAmount: Double {
        return totalAmount
    }

    func item(at index: Int) -> CartItem {
        guard index >= 0 && index < cartItems.count else {
            fatalError("Index out of bounds")
        }
        return cartItems[index]
    }

    func viewDidLoad() {
        fetchCartItems()
    }

    func viewWillAppear() {
        updateCart()
    }

    func viewWillDisappear() {
        // Gerekiyorsa state temizleme işlemleri
    }
}
