// ShopFlow/Core/Models/Task.swift
import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String?
    let priority: Priority
    let dueTime: Date?
    let createdAt: Date
    let relatedFeature: FeatureType?
    var status: TaskStatus
    var assignedTo: String?
    var completedAt: Date?
    var completedBy: String?
    
    var isOverdue: Bool {
        guard let dueTime = dueTime else { return false }
        return dueTime < Date() && status != .complete
    }
    
    var timeRemaining: String? {
        guard let dueTime = dueTime else { return nil }
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date(), to: dueTime)
        
        if let hours = components.hour, let minutes = components.minute {
            if hours > 0 {
                return "\(hours)h \(minutes)m"
            } else if minutes > 0 {
                return "\(minutes)m"
            } else {
                return "Overdue"
            }
        }
        return nil
    }
}

// MARK: - Task Enums
extension Task {
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
    
    enum TaskStatus: String, Codable {
        case notStarted = "Not Started"
        case inProgress = "In Progress"
        case complete = "Complete"
        case cancelled = "Cancelled"
        
        var sfSymbol: String {
            switch self {
            case .notStarted: return "circle"
            case .inProgress: return "clock.fill"
            case .complete: return "checkmark.circle.fill"
            case .cancelled: return "xmark.circle"
            }
        }
    }
    
    enum FeatureType: String, Codable {
        case orderFulfillment = "Order Fulfillment"
        case replenishment = "Replenishment"
        case topStock = "Top Stock"
        case expiration = "Expiration Management"
        case receiving = "Receiving"
        case shelfCapture = "Shelf Capture"
        case inventory = "Inventory"
        case other = "Other"
        
        var sfSymbol: String {
            switch self {
            case .orderFulfillment: return "shippingbox.fill"
            case .replenishment: return "arrow.triangle.2.circlepath"
            case .topStock: return "arrow.up.square.fill"
            case .expiration: return "calendar.badge.exclamationmark"
            case .receiving: return "shippingbox.and.arrow.backward"
            case .shelfCapture: return "camera.fill"
            case .inventory: return "cube.box.fill"
            case .other: return "folder.fill"
            }
        }
    }
}
