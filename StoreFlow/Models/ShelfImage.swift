// ShopFlow/Core/Models/ShelfImage.swift
import Foundation

struct ShelfImage: Identifiable, Codable {
    let id: UUID
    let imageURL: URL?
    let localImagePath: String?
    let timestamp: Date
    let location: String
    let aisle: String?
    let bay: String?
    let shelf: String?
    let capturedBy: String
    var metadata: [String: String]
    var uploadStatus: UploadStatus
    
    var displayLocation: String {
        if let aisle = aisle, let bay = bay, let shelf = shelf {
            return "Aisle \(aisle) - Bay \(bay) - Shelf \(shelf)"
        }
        return location
    }
}

extension ShelfImage {
    enum UploadStatus: String, Codable {
        case pending = "Pending"
        case uploading = "Uploading"
        case uploaded = "Uploaded"
        case failed = "Failed"
        
        var sfSymbol: String {
            switch self {
            case .pending: return "clock"
            case .uploading: return "arrow.up.circle"
            case .uploaded: return "checkmark.circle.fill"
            case .failed: return "exclamationmark.triangle.fill"
            }
        }
    }
}
