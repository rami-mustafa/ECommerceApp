//
//  ProductDetailViewModel.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 21.12.24.
//

import Foundation

protocol ProductDetailViewDelegate: AnyObject {
    func updateImage(_ imageUrl: String)
    func updateTitle(_ title: String)
    func updateDescription(_ description: String)
    func updatePrice(_ price: String)
}

final class ProductDetailViewModel {
    weak var delegate: ProductDetailViewDelegate?
     let product: Product

    init(product: Product) {
        self.product = product
    }

    func viewDidLoad() {
        delegate?.updateImage(product.image ?? "")
        delegate?.updateTitle(product.safeName)
        delegate?.updateDescription(product.description ?? "No description available.")
        delegate?.updatePrice("\(product.safePrice)")
    }
}
