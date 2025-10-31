//
//  PickListItem.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


// ShopFlow/Core/Models/PickListItem.swift
import Foundation

struct PickListItem: Identifiable, Codable, Equatable {
    let id: UUID
    let product: Product
    let quantity: Int
    var scannedQuantity: Int
    var status: PickStatus
    let priority: Priority?
    var lastScannedAt: Date?
    var notes: String?
    
    var isComplete: Bool {
        scannedQuantity >= quantity
    }
    
    var remainingQuantity: Int {
        max(0, quantity - scannedQuantity)
    }
    
    var completionPercentage: Double {
        guard quantity > 0 else { return 0 }
        return min(1.0, Double(scannedQuantity) / Double(quantity))
    }
    
    mutating func incrementScanned(by amount: Int = 1) {
        scannedQuantity += amount
        lastScannedAt = Date()
        updateStatus()
    }
    
    private mutating func updateStatus() {
        if scannedQuantity >= quantity {
            status = .complete
        } else if scannedQuantity > 0 {
            status = .partial
        } else {
            status = .pending
        }
    }
}

// MARK: - Pick Status
extension PickListItem {
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
            case .skipped: return "xmark.circle"
            }
        }
    }
    
    enum Priority: String, Codable, CaseIterable {
        case high = "High"
        case medium = "Medium"
        case low = "Low"
        
        var sfSymbol: String {
            switch self {
            case .high: return "exclamationmark.3"
            case .medium: return "exclamationmark.2"
            case .low: return "exclamationmark"
            }
        }
        
        var sortOrder: Int {
            switch self {
            case .high: return 0
            case .medium: return 1
            case .low: return 2
            }
        }
    }
}
