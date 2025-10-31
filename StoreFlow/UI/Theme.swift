//
//  Theme.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


// ShopFlow/Core/UI/Theme.swift
import SwiftUI

/// Centralized theme and design system
enum Theme {
    
    // MARK: - Colors
    enum Colors {
        // Primary brand colors
        static let primary = Color("PrimaryColor", bundle: nil) ?? Color.blue
        static let secondary = Color("SecondaryColor", bundle: nil) ?? Color.orange
        static let accent = Color("AccentColor", bundle: nil) ?? Color.green
        
        // Semantic colors
        static let success = Color.green
        static let warning = Color.orange
        static let error = Color.red
        static let info = Color.blue
        
        // Status colors for pick lists
        static let pending = Color.gray
        static let partial = Color.orange
        static let complete = Color.green
        
        // Priority colors
        static let highPriority = Color.red
        static let mediumPriority = Color.orange
        static let lowPriority = Color.blue
        
        // Expiration status colors
        static let critical = Color.red
        static let warningExpiration = Color.orange
        static let monitor = Color.yellow
        static let ok = Color.green
        
        // Background colors
        static let background = Color(UIColor.systemBackground)
        static let secondaryBackground = Color(UIColor.secondarySystemBackground)
        static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
        
        // Text colors
        static let primaryText = Color(UIColor.label)
        static let secondaryText = Color(UIColor.secondaryLabel)
        static let tertiaryText = Color(UIColor.tertiaryLabel)
        
        // Border and separator
        static let border = Color(UIColor.separator)
        static let divider = Color(UIColor.separator).opacity(0.5)
    }
    
    // MARK: - Typography
    enum Typography {
        // Titles
        static let largeTitle = Font.largeTitle.weight(.bold)
        static let title = Font.title.weight(.semibold)
        static let title2 = Font.title2.weight(.semibold)
        static let title3 = Font.title3.weight(.medium)
        
        // Body
        static let body = Font.body
        static let bodyBold = Font.body.weight(.semibold)
        static let callout = Font.callout
        
        // Supporting
        static let caption = Font.caption
        static let caption2 = Font.caption2
        static let footnote = Font.footnote
        
        // Custom
        static let statValue = Font.system(size: 32, weight: .bold, design: .rounded)
        static let statLabel = Font.caption.weight(.medium)
        static let badge = Font.system(size: 12, weight: .semibold)
    }
    
    // MARK: - Spacing
    enum Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }
    
    // MARK: - Corner Radius
    enum CornerRadius {
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
        static let pill: CGFloat = 999
    }
    
    // MARK: - Shadows
    enum Shadows {
        static let small = Shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        static let medium = Shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
        static let large = Shadow(color: .black.opacity(0.2), radius: 16, x: 0, y: 8)
    }
    
    struct Shadow {
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat
    }
    
    // MARK: - Icons
    enum Icons {
        // Feature icons
        static let orderFulfillment = "shippingbox.fill"
        static let replenishment = "arrow.triangle.2.circlepath"
        static let topStock = "arrow.up.square.fill"
        static let expiration = "calendar.badge.exclamationmark"
        static let receiving = "shippingbox.and.arrow.backward"
        static let shelfCapture = "camera.fill"
        static let tasks = "checklist"
        
        // Action icons
        static let scan = "barcode.viewfinder"
        static let camera = "camera"
        static let checkmark = "checkmark.circle.fill"
        static let xmark = "xmark.circle.fill"
        static let info = "info.circle"
        static let settings = "gear"
        
        // Navigation
        static let back = "chevron.left"
        static let forward = "chevron.right"
        static let close = "xmark"
        
        // Status
        static let pending = "clock.fill"
        static let complete = "checkmark.seal.fill"
        static let warning = "exclamationmark.triangle.fill"
        static let error = "xmark.octagon.fill"
    }
}

// MARK: - View Modifiers
extension View {
    /// Apply card styling
    func cardStyle() -> some View {
        self
            .background(Theme.Colors.background)
            .cornerRadius(Theme.CornerRadius.md)
            .shadow(color: Theme.Shadows.small.color, 
                    radius: Theme.Shadows.small.radius,
                    x: Theme.Shadows.small.x, 
                    y: Theme.Shadows.small.y)
    }
    
    /// Apply primary button styling
    func primaryButtonStyle() -> some View {
        self
            .font(Theme.Typography.bodyBold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Theme.Colors.primary)
            .cornerRadius(Theme.CornerRadius.md)
    }
    
    /// Apply secondary button styling
    func secondaryButtonStyle() -> some View {
        self
            .font(Theme.Typography.bodyBold)
            .foregroundColor(Theme.Colors.primary)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Theme.Colors.primary.opacity(0.1))
            .cornerRadius(Theme.CornerRadius.md)
    }
}
