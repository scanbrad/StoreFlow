// ShopFlow/Core/Models/ManifestStatus.swift
import Foundation

enum ManifestStatus: String, Codable {
    case pending = "Pending"
    case receiving = "Receiving"
    case complete = "Complete"
    case discrepancy = "Discrepancy"
    case cancelled = "Cancelled"
    
    var sfSymbol: String {
        switch self {
        case .pending: return "clock"
        case .receiving: return "arrow.down.circle.fill"
        case .complete: return "checkmark.circle.fill"
        case .discrepancy: return "exclamationmark.triangle.fill"
        case .cancelled: return "xmark.circle.fill"
        }
    }
}
