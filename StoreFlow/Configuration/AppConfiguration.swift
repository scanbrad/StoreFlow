// ShopFlow/Core/Configuration/AppConfiguration.swift
import Foundation

/// Application-wide configuration and feature flags
enum AppConfiguration {
    
    // MARK: - App Info
    static let appName = "ShopFlow"
    static let version = "1.0.0"
    static let buildNumber = "1"
    
    // MARK: - Feature Flags
    struct Features {
        static let orderFulfillmentEnabled = true
        static let replenishmentEnabled = true
        static let topStockEnabled = true
        static let expirationManagementEnabled = true
        static let receivingEnabled = true
        static let shelfCaptureEnabled = true
        static let taskManagementEnabled = true
        
        // Advanced features
        static let offlineModeEnabled = false
        static let analyticsEnabled = true
        static let debugModeEnabled = true
    }
    
    // MARK: - UI Configuration
    struct UI {
        static let animationDuration: TimeInterval = 0.3
        static let hapticFeedbackEnabled = true
        static let showDebugInfo = false
        
        // List view settings
        static let defaultListItemHeight: CGFloat = 80
        static let compactListItemHeight: CGFloat = 60
    }
    
    // MARK: - Data Configuration
    struct Data {
        static let useMockData = true // Set to false when connecting to real backend
        static let cacheExpirationMinutes = 30
        static let maxCachedItems = 1000
    }
    
    // MARK: - Scanning Configuration
    struct Scanning {
        static let continuousScanningEnabled = true
        static let duplicateScanDelaySeconds: TimeInterval = 2.0
        static let autoAdvanceOnComplete = true
    }
    
    // MARK: - Expiration Management
    struct Expiration {
        static let criticalDaysThreshold = 3
        static let warningDaysThreshold = 7
        static let monitorDaysThreshold = 14
    }
    
    // MARK: - User Defaults Keys
    struct UserDefaultsKeys {
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
        static let preferredScanMode = "preferredScanMode"
        static let userName = "userName"
        static let userRole = "userRole"
        static let lastSyncDate = "lastSyncDate"
        static let totalScansCount = "totalScansCount"
        static let sessionStartTime = "sessionStartTime"
    }
}
