//
//  Product.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


// ShopFlow/Core/Models/Product.swift
import Foundation

struct Product: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let upc: String
    let sku: String
    let category: ProductCategory
    let imageURL: String?
    let price: Decimal
    let location: String
    let weight: Double?
    var expirationDate: Date?
    var stockLevel: Int?
    var reorderPoint: Int?
    
    var displayLocation: String {
        location
    }
    
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: price as NSDecimalNumber) ?? "$0.00"
    }
}

// MARK: - Product Category
extension Product {
    enum ProductCategory: String, Codable, CaseIterable {
        case dairy = "Dairy"
        case produce = "Produce"
        case meatDeli = "Meat/Deli"
        case bakery = "Bakery"
        case packagedGoods = "Packaged Goods"
        case frozen = "Frozen"
        case beverages = "Beverages"
        case other = "Other"
        
        var sfSymbol: String {
            switch self {
            case .dairy: return "drop.fill"
            case .produce: return "leaf.fill"
            case .meatDeli: return "fork.knife"
            case .bakery: return "birthday.cake.fill"
            case .packagedGoods: return "shippingbox.fill"
            case .frozen: return "snowflake"
            case .beverages: return "cup.and.saucer.fill"
            case .other: return "cube.box.fill"
            }
        }
    }
}
