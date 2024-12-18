//
//  DataRequest.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 17.12.24.
//

import Foundation

final class DataRequest {
    func request<T: Decodable>(_ url: String, method: HTTPMethod) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse(statusCode: 0) // Undefined status
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse(statusCode: httpResponse.statusCode)
        }

        print("HTTP Response Status Code: \(httpResponse.statusCode)")
     //   print(String(data: data, encoding: .utf8) ?? "No data received")

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}


