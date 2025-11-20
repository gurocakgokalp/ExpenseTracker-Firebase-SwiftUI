//
//  AppColors.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 19.11.2025.
//
import SwiftUI

struct AppTypography {
    static let h1: CGFloat = 32
    static let h2: CGFloat = 24
    static let h3: CGFloat = 20
    static let body: CGFloat = 16
    static let caption: CGFloat = 14
    static let tiny: CGFloat = 12
    
    static let bold = Font.Weight.bold
    static let semibold = Font.Weight.semibold
    static let regular = Font.Weight.regular
    
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 24
    static let xxl: CGFloat = 32
}
// MARK: - Brand Colors
struct AppColors {
    // Primary Brand
    static let primary = Color(red: 0.2, green: 0.5, blue: 1.0)          // #3380FF - Main Blue
    static let primaryLight = Color(red: 0.4, green: 0.65, blue: 1.0)    // #66A6FF - Light Blue
    static let primaryDark = Color(red: 0.1, green: 0.35, blue: 0.8)     // #1A59CC - Dark Blue
    
    // Status Colors
    static let success = Color(red: 0.2, green: 0.8, blue: 0.4)          // #33CC66 - Green (Safe)
    static let warning = Color(red: 1.0, green: 0.7, blue: 0.0)          // #FFB300 - Orange (Warning)
    static let danger = Color(red: 1.0, green: 0.3, blue: 0.3)           // #FF4D4D - Red (Danger)
    static let info = Color(red: 0.0, green: 0.7, blue: 1.0)             // #00B3FF - Cyan (Info)
    
    // Backgrounds
    static let bgPrimary = Color(UIColor.systemBackground)               // White (Light) / Black (Dark)
    static let bgSecondary = Color(UIColor.secondarySystemBackground)    // Light Gray / Dark Gray
    static let bgTertiary = Color(UIColor.tertiarySystemBackground)      // Lighter Gray / Darker Gray
    
    // Text Colors
    static let textPrimary = Color(UIColor.label)                        // Black (Light) / White (Dark)
    static let textSecondary = Color(UIColor.secondaryLabel)             // Dark Gray (Light) / Light Gray (Dark)
    static let textTertiary = Color(UIColor.tertiaryLabel)               // Medium Gray
    
    // Category Colors (Pie Chart)
    static let catFood = Color(red: 1.0, green: 0.65, blue: 0.0)         // #FFA500 - Orange
    static let catTransport = Color(red: 0.2, green: 0.6, blue: 1.0)     // #3399FF - Blue
    static let catShopping = Color(red: 1.0, green: 0.2, blue: 0.6)      // #FF3399 - Pink
    static let catEntertainment = Color(red: 0.6, green: 0.2, blue: 1.0) // #9933FF - Purple
    static let catUtilities = Color(red: 1.0, green: 0.85, blue: 0.0)    // #FFD700 - Gold
    static let catOther = Color(red: 0.6, green: 0.6, blue: 0.6)         // #999999 - Gray
    
    // Chart Colors
    static let chartLine = Color(red: 0.2, green: 0.5, blue: 1.0)        // #3380FF - Blue (same as primary)
    static let chartAreaFill = Color(red: 0.2, green: 0.5, blue: 1.0)    // #3380FF with opacity
    static let chartGrid = Color(red: 0.9, green: 0.9, blue: 0.9)        // #E6E6E6 - Light Gray
    
    // Borders & Dividers
    static let border = Color(red: 0.85, green: 0.85, blue: 0.85)        // #D9D9D9
    static let divider = Color(UIColor.separator)                        // System separator
    
    // Shadows
    static let shadowLight = Color.black.opacity(0.1)
    static let shadowMedium = Color.black.opacity(0.2)
    static let shadowDark = Color.black.opacity(0.3)
}

// MARK: - Category Color Mapping
struct CategoryColor {
    static let mapping: [String: Color] = [
        "Food": AppColors.catFood,
        "Transport": AppColors.catTransport,
        "Shopping": AppColors.catShopping,
        "Entertainment": AppColors.catEntertainment,
        "Utilities": AppColors.catUtilities,
        "Other": AppColors.catOther
    ]
    
    static func color(for category: String) -> Color {
        return mapping[category] ?? AppColors.catOther
    }
}

// MARK: - Budget Status Color
struct BudgetStatusColor {
    static func color(used: Double, total: Double) -> Color {
        let percentage = used / total
        
        if percentage > 1.0 {                  // Over budget
            return AppColors.danger            // 🔴 Red
        } else if percentage > 0.95 {          // >95% used
            return AppColors.warning           // 🟡 Orange
        } else if percentage > 0.80 {          // >80% used
            return AppColors.info              // 🔵 Cyan (light blue)
        } else {                               // Safe
            return AppColors.success           // 🟢 Green
        }
    }
    
    static func statusText(used: Double, total: Double) -> String {
        let percentage = used / total
        
        if percentage > 1.0 {
            let over = (used - total)
            return "Over Budget by $\(String(format: "%.2f", over))"
        } else if percentage > 0.95 {
            return "Budget Warning - Almost at limit!"
        } else if percentage > 0.80 {
            return "\(Int(percentage * 100))% of budget used"
        } else {
            let remaining = total - used
            return "Budget OK - $\(String(format: "%.2f", remaining)) remaining"
        }
    }
}
