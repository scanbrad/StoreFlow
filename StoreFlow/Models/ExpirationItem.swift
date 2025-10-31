// ShopFlow/Core/Models/ExpirationItem.swift
import Foundation

struct ExpirationItem: Identifiable, Codable, Equatable {
    let id: UUID
    let product: Product
    let expirationDate: Date
    let scannedDate: Date
    var status: ExpirationStatus
    var action: RecommendedAction?
    var quantity: Int
    var location: String
    var handledBy: String?
    var handledAt: Date?
    var notes: String?
    
    var daysRemaining: Int {
        Calendar.current.dateComponents([.day], from: Date(), to: expirationDate).day ?? 0
    }
    
    var isExpired: Bool {
        daysRemaining < 0
    }
    
    var displayDaysRemaining: String {
        if isExpired {
            return "Expired \(abs(daysRemaining)) day(s) ago"
        } else if daysRemaining == 0 {
            return "Expires today"
        } else if daysRemaining == 1 {
            return "Expires tomorrow"
        } else {
            return "\(daysRemaining) days remaining"
        }
    }
    
    static func determineStatus(daysRemaining: Int) -> ExpirationStatus {
        switch daysRemaining {
        case ..<3:
            return .critical
        case 3...7:
            return .warning
        case 8...14:
            return .monitor
        default:
            return .ok
        }
    }
    
    static func determineAction(for status: ExpirationStatus) -> RecommendedAction {
        switch status {
        case .critical:
            return .remove
        case .warning:
            return .markdown
        case .monitor:
            return .frontFace
        case .ok:
            return .none
        }
    }
}

// MARK: - Expiration Status
extension ExpirationItem {
    enum ExpirationStatus: String, Codable {
        case critical = "Critical"
        case warning = "Warning"
        case monitor = "Monitor"
        case ok = "OK"
        
        var sfSymbol: String {
            switch self {
            case .critical: return "exclamationmark.triangle.fill"
            case .warning: return "exclamationmark.circle.fill"
            case .monitor: return "eye.fill"
            case .ok: return "checkmark.circle.fill"
            }
        }
    }
    
    enum RecommendedAction: String, Codable {
        case remove = "Remove from shelf"
        case markdown = "Apply markdown"
        case frontFace = "Front face"
        case none = "No action needed"
        
        var sfSymbol: String {
            switch self {
            case .remove: return "trash.fill"
            case .markdown: return "tag.fill"
            case .frontFace: return "arrow.forward.square.fill"
            case .none: return "checkmark.circle.fill"
            }
        }
    }
}
