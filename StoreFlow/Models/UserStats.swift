// ShopFlow/Core/Models/UserModels.swift
import Foundation

struct UserStats: Codable {
    let openOrders: Int
    let unitsPerHour: Int
    let modsToCapture: Int
    let accuracy: Double
    let lastUpdated: Date
    let totalScansToday: Int
    let ordersCompletedToday: Int
    let currentStreak: Int
    
    var accuracyPercentage: Int {
        Int(accuracy * 100)
    }
    
    var formattedAccuracy: String {
        "\(accuracyPercentage)%"
    }
}

struct UserSession: Codable {
    let userId: String
    let userName: String
    let role: UserRole
    let startTime: Date
    var endTime: Date?
    var scansCount: Int
    var ordersCompleted: Int
    
    var duration: TimeInterval {
        let end = endTime ?? Date()
        return end.timeIntervalSince(startTime)
    }
    
    var formattedDuration: String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        return String(format: "%02d:%02d", hours, minutes)
    }
}

extension UserSession {
    enum UserRole: String, Codable {
        case associate = "Associate"
        case lead = "Team Lead"
        case manager = "Manager"
        case admin = "Admin"
        
        var sfSymbol: String {
            switch self {
            case .associate: return "person.fill"
            case .lead: return "person.2.fill"
            case .manager: return "person.3.fill"
            case .admin: return "crown.fill"
            }
        }
    }
}
