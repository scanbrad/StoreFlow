// ShopFlow/Core/Models/ProductCategory.swift
import Foundation

enum ProductCategory: String, Codable, CaseIterable {
    case dairy = "Dairy"
    case produce = "Produce"
    case meatDeli = "Meat/Deli"
    case bakery = "Bakery"
    case packagedGoods = "Packaged Goods"
    case frozen = "Frozen"
    case beverages = "Beverages"
    case other = "Other"
    
    var icon: String {
        switch self {
        case .dairy: return "🥛"
        case .produce: return "🥬"
        case .meatDeli: return "🥩"
        case .bakery: return "🍞"
        case .packagedGoods: return "📦"
        case .frozen: return "❄️"
        case .beverages: return "🥤"
        case .other: return "📦"
        }
    }
    
    // SF Symbol alternative (Apple HIG compliant)
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
