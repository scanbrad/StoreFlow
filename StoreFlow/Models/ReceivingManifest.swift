// ShopFlow/Core/Models/ReceivingManifest.swift
import Foundation

struct ReceivingManifest: Identifiable, Codable {
    let id: UUID
    let poNumber: String
    let vendor: String
    let expectedDate: Date
    var receivedDate: Date?
    var items: [ManifestItem]
    var status: ManifestStatus
    var receivedBy: String?
    var notes: String?
    
    var totalExpected: Int {
        items.reduce(0) { $0 + $1.expectedQuantity }
    }
    
    var totalReceived: Int {
        items.reduce(0) { $0 + $1.receivedQuantity }
    }
    
    var hasDiscrepancies: Bool {
        items.contains { $0.hasDiscrepancy }
    }
    
    var completionPercentage: Double {
        guard totalExpected > 0 else { return 0 }
        return Double(totalReceived) / Double(totalExpected)
    }
    
    var discrepancyCount: Int {
        items.filter { $0.hasDiscrepancy }.count
    }
}

// MARK: - Manifest Status
extension ReceivingManifest {
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
            case .cancelled: return "xmark.circle"
            }
        }
    }
}

// MARK: - Manifest Item
struct ManifestItem: Identifiable, Codable {
    let id: UUID
    let product: Product
    let expectedQuantity: Int
    var receivedQuantity: Int
    var notes: String?
    var scannedAt: Date?
    var damageReported: Bool
    var qualityIssue: Bool
    
    var hasDiscrepancy: Bool {
        receivedQuantity != expectedQuantity
    }
    
    var variance: Int {
        receivedQuantity - expectedQuantity
    }
    
    var varianceType: VarianceType {
        if variance > 0 {
            return .overage
        } else if variance < 0 {
            return .shortage
        } else {
            return .match
        }
    }
    
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
}
