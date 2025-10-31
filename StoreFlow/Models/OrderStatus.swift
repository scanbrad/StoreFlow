// ShopFlow/Core/Models/OrderStatus.swift
import Foundation

enum OrderStatus: String, Codable {
    case pending = "Pending"
    case inProgress = "In Progress"
    case complete = "Complete"
    case cancelled = "Cancelled"
    
    var sfSymbol: String {
        switch self {
        case .pending: return "clock"
        case .inProgress: return "arrow.clockwise"
        case .complete: return "checkmark.circle.fill"
        case .cancelled: return "xmark.circle.fill"
        }
    }
}
