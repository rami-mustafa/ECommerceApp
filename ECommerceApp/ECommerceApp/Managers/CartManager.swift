//
//  CartManager.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 22.12.24.
//

import Foundation
import CoreData
import UIKit

protocol CartManagerProtocol {
    var totalCartAmount: Double { get }
    func addProductToCart(_ product: Product)
    func incrementProductQuantity(productId: String)
    func decrementProductQuantity(productId: String)
    func fetchCartItems() -> [CartItem]
    func clearCart()
}


final class CartManager: CartManagerProtocol {
    static let shared = CartManager()
    
    private init() {}

    private var context: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate not found")
        }
        return appDelegate.persistentContainer.viewContext
    }

    var totalCartAmount: Double {
        let items = fetchCartItems()
        return items.reduce(0) { $0 + ($1.price * Double($1.numberOfCart)) }
    }

    func addProductToCart(_ product: Product) {
        let items = fetchCartItems()
        if let existingItem = items.first(where: { $0.id == product.id }) {
            existingItem.numberOfCart += 1
        } else {
            let newItem = CartItem(context: context)
            newItem.id = product.id ?? UUID().uuidString
            newItem.name = product.safeName
            newItem.price = Double(product.safePrice) ?? 0.0 
            newItem.descriptionText = product.description ?? ""
            newItem.numberOfCart = 1
        }
        saveContext()
    }


    func incrementProductQuantity(productId: String) {
        if let item = fetchCartItems().first(where: { $0.id == productId }) {
            item.numberOfCart += 1
            saveContext()
        }
    }

    func decrementProductQuantity(productId: String) {
        if let item = fetchCartItems().first(where: { $0.id == productId }) {
            if item.numberOfCart > 1 {
                item.numberOfCart -= 1
            } else {
                context.delete(item)
            }
            saveContext()
        }
    }

    func fetchCartItems() -> [CartItem] {
        let request: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch cart items: \(error.localizedDescription)")
            return []
        }
    }

    func clearCart() {
        let items = fetchCartItems()
        for item in items {
            context.delete(item)
        }
        saveContext()
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
    
    func updateQuantity(for productId: String, quantity: Int) {
        guard let item = fetchCartItems().first(where: { $0.id == productId }) else {
            print("Item not found")
            return
        }
        item.numberOfCart = Int32(quantity)
        saveContext()
    }
    
    func totalItemCount() -> Int {
        let items = fetchCartItems()
        return items.reduce(0) { $0 + Int($1.numberOfCart) }
    }

    
    private var cartItemCount: Int = 0

    func incrementCartCount() {
        cartItemCount += 1
    }

    func resetCartCount() {
        cartItemCount = 0
    }

    func getCartCount() -> Int {
        return cartItemCount
    }
    func isCartEmpty() -> Bool {
        return fetchCartItems().isEmpty
    }
}
