//
//  FilterManager.swift
//  ECommerceApp
//
//  Created by Rami Mustafa on 21.12.24.
//

import Foundation

final class FilterManager {
    static let shared = FilterManager()
    
    private init() {}
    
    var selectedSortOption: String?
    var selectedBrands: [String] = []
    var selectedModels: [String] = []
    
    func resetFilters() {
        selectedSortOption = nil
        selectedBrands = []
        selectedModels = []
    }
}
