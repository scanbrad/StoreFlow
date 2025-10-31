// ShopFlow/Core/Models/RecommendedAction.swift
import Foundation

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
