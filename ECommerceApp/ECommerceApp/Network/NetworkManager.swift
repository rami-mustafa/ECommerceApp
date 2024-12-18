//
//  NetworkManager.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 17.12.24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let dataRequest = DataRequest()

    private init() {}
    
    func fetchProducts() async throws -> [Product] {
        return try await dataRequest.request(Endpoint.products, method: .get)
    }
}

