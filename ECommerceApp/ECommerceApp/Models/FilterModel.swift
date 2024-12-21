//
//  FilterModel.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 17.12.24.
//

import Foundation

enum FilterType: String {
    case sortBy = "Sort By"
    case brand = "Brand"
    case model = "Model"
}

struct FilterModel: Hashable {
    let type: FilterType  // Filtre türü (Sort By, Brand, Model)
    let name: String      // Seçeneğin adı (örn: "Old to New", "Samsung")
    var isChecked: Bool = false  // Seçili olup olmadığını takip eder
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(name)
    }
    
    static func == (lhs: FilterModel, rhs: FilterModel) -> Bool {
        return lhs.type == rhs.type && lhs.name == rhs.name
    }
}
