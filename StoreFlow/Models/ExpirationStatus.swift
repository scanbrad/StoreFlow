// ShopFlow/Core/Models/ExpirationStatus.swift
import Foundation

enum ExpirationStatus: String, Codable {
    case critical = "Critical"  // < 3 days or expired
    case warning = "Warning"    // 3-7 days
    case monitor = "Monitor"    // 8-14 days
    case ok = "OK"              // > 14 days
    
    var sfSymbol: String {
        switch self {
        case .critical: return "exclamationmark.triangle.fill"
        case .warning: return "exclamationmark.circle.fill"
        case .monitor: return "eye.fill"
        case .ok: return "checkmark.circle.fill"
        }
    }
}
