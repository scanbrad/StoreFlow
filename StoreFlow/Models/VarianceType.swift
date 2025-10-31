// ShopFlow/Core/Models/VarianceType.swift
import Foundation

enum VarianceType {
    case overage
    case shortage
    case match
    
    var sfSymbol: String {
        switch self {
        case .overage: return "plus.circle.fill"
        case .shortage: return "minus.circle.fill"
        case .match: return "checkmark.circle.fill"
        }
    }
}
