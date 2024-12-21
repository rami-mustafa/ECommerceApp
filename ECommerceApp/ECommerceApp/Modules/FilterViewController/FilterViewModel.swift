//
//  FilterViewModel.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 21.12.24.
//

import Foundation

final class FilterViewModel {
    
    private(set) var brands: [String] = [
        "Lamborghini", "Smart", "Ferrari", "Volkswagen", "Tesla",
        "BMW", "Audi", "Mercedes-Benz", "Porsche", "Ford",
        "Chevrolet", "Nissan", "Toyota", "Hyundai", "Kia",
        "Mazda", "Jeep", "Subaru", "Volvo", "Jaguar"
    ]

    private(set) var models: [String] = [
        "Roadster", "CTS", "Taurus", "Jetta", "Fortwo",
        "Model S", "A4", "C-Class", "Cayenne", "Mustang",
        "Camaro", "Altima", "Corolla", "Elantra", "Sorento",
        "CX-5", "Wrangler", "Impreza", "XC90", "F-Type"
    ]
 
    private var filteredBrands: [String] = []
    private var filteredModels: [String] = []

    var isFilteringBrands: Bool = false
    var isFilteringModels: Bool = false

    var brandCount: Int {
        return isFilteringBrands ? filteredBrands.count : brands.count
    }

    var modelCount: Int {
        return isFilteringModels ? filteredModels.count : models.count
    }

    func brand(at index: Int) -> String {
        return isFilteringBrands ? filteredBrands[index] : brands[index]
    }

    func model(at index: Int) -> String {
        return isFilteringModels ? filteredModels[index] : models[index]
    }

    func filterBrands(with text: String) {
        if text.isEmpty {
            isFilteringBrands = false
        } else {
            isFilteringBrands = true
            let lowercasedText = text.lowercased()
            filteredBrands = brands.filter { brand in
                brand.lowercased().range(of: lowercasedText, options: [.anchored, .caseInsensitive]) != nil
            }
        }
    }

    func filterModels(with text: String) {
        if text.isEmpty {
            isFilteringModels = false
        } else {
            isFilteringModels = true
            let lowercasedText = text.lowercased()
            filteredModels = models.filter { model in
                model.lowercased().range(of: lowercasedText, options: [.anchored, .caseInsensitive]) != nil
            }
        }
    }
}

