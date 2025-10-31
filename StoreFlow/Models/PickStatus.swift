//
//  PickStatus.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


// ShopFlow/Core/Models/PickStatus.swift
import Foundation

enum PickStatus: String, Codable {
    case pending = "Pending"
    case partial = "Partial"
    case complete = "Complete"
    case skipped = "Skipped"
    
    var sfSymbol: String {
        switch self {
        case .pending: return "clock"
        case .partial: return "clock.badge.exclamationmark"
        case .complete: return "checkmark.circle.fill"
        case .skipped: return "xmark.circle.fill"
        }
    }
}
