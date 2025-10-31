//
//  ScanditConfiguration.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


// ShopFlow/Core/Configuration/ScanditConfiguration.swift
import Foundation
import ScanditBarcodeCapture

/// Centralized configuration for Scandit SDK
/// Contains license key, symbology presets, and mode-specific settings
enum ScanditConfiguration {
    
    // MARK: - License Key
    /// TODO: Replace with your actual Scandit license key from https://ssl.scandit.com/dashboard
    static let licenseKey = "YOUR_SCANDIT_LICENSE_KEY_HERE"
    
    // MARK: - Symbology Configuration
    /// Standard retail symbologies used across all scanning modes
    static let retailSymbologies: Set<Symbology> = [
        .ean13UPCA,
        .ean8,
        .upce,
        .code128,
        .code39,
        .qr,
        .dataMatrix
    ]
    
    /// Symbologies specifically for grocery/perishables (includes GS1)
    static let grocerySymbologies: Set<Symbology> = [
        .ean13UPCA,
        .ean8,
        .upce,
        .code128,
        .gs1Databar,
        .gs1DatabarExpanded,
        .gs1DatabarLimited
    ]
    
    // MARK: - Feedback Settings
    static let enableVibration = true
    static let enableSound = true
    
    // MARK: - Camera Settings
    static let preferredResolution = VideoResolution.fullHD
    static let preferredFrameRate: Float = 30.0
    
    // MARK: - SparkScan Specific
    struct SparkScan {
        static let scanIntents: [ScanIntents] = [.smart]
        static let previewBehavior = SparkScanPreviewBehavior.default
        static let triggerButtonCollapseTimeout: TimeInterval = 0.5
    }
    
    // MARK: - MatrixScan Pick Specific
    struct Pick {
        static let enableHaptics = true
        static let enableSoundFeedback = true
        static let arOverlayEnabled = true
    }
    
    // MARK: - MatrixScan Count Specific
    struct Count {
        static let enableSpatialGrid = true
        static let enableClustering = false
        static let expectOnlyUniqueBarcodes = false
    }
    
    // MARK: - MatrixScan Find Specific
    struct Find {
        static let enableHaptics = true
        static let enableSoundFeedback = true
    }
    
    // MARK: - Helper Methods
    
    /// Apply symbology settings to any settings object
    static func applyRetailSymbologies<T>(to settings: T) where T: AnyObject {
        for symbology in retailSymbologies {
            if let sparkScanSettings = settings as? SparkScanSettings {
                sparkScanSettings.set(symbology: symbology, enabled: true)
            } else if let pickSettings = settings as? BarcodePickSettings {
                pickSettings.set(symbology: symbology, enabled: true)
            } else if let findSettings = settings as? BarcodeFindSettings {
                findSettings.set(symbology: symbology, enabled: true)
            } else if let countSettings = settings as? BarcodeCountSettings {
                countSettings.set(symbology: symbology, enabled: true)
            } else if let captureSettings = settings as? BarcodeCaptureSettings {
                captureSettings.set(symbology: symbology, enabled: true)
            }
        }
    }
    
    /// Configure GS1 extensions for expiration date parsing
    static func enableGS1Extensions<T>(on settings: T) where T: AnyObject {
        // Enable GS1 for EAN/UPC codes to parse expiration dates
        if let sparkScanSettings = settings as? SparkScanSettings {
            let ean13Settings = sparkScanSettings.settings(for: .ean13UPCA)
            ean13Settings.setExtension("relaxed_sharp_quiet_zone_check", enabled: true)
        } else if let captureSettings = settings as? BarcodeCaptureSettings {
            let ean13Settings = captureSettings.settings(for: .ean13UPCA)
            ean13Settings.setExtension("relaxed_sharp_quiet_zone_check", enabled: true)
        }
    }
}
