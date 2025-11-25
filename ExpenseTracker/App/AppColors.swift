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
    static let bgPrimary = Color(UIColor.systemBackground)               
    static let bgSecondary = Color(UIColor.secondarySystemBackground)
    static let bgTertiary = Color(UIColor.tertiarySystemBackground)
    
    // Text Colors
    static let textPrimary = Color(UIColor.label)
    static let textSecondary = Color(UIColor.secondaryLabel)
    static let textTertiary = Color(UIColor.tertiaryLabel)
    
    // Category Colors (Pie Chart)
    static let catFood = Color(red: 1.0, green: 0.65, blue: 0.0)         // #FFA500 - Orange
    static let catTransport = Color(red: 0.2, green: 0.6, blue: 1.0)     // #3399FF - Blue
    static let catShopping = Color(red: 1.0, green: 0.2, blue: 0.6)      // #FF3399 - Pink
    static let catEntertainment = Color(red: 0.6, green: 0.2, blue: 1.0) // #9933FF - Purple
    static let catUtilities = Color(red: 1.0, green: 0.85, blue: 0.0)    // #FFD700 - Gold
    static let catOther = Color(red: 0.6, green: 0.6, blue: 0.6)         // #999999 - Gray
    

    static let chartLine = Color(red: 0.2, green: 0.5, blue: 1.0)
    static let chartAreaFill = Color(red: 0.2, green: 0.5, blue: 1.0)    // #3380FF with opacity
    static let chartGrid = Color(red: 0.9, green: 0.9, blue: 0.9)
    

    static let border = Color(red: 0.85, green: 0.85, blue: 0.85)
    static let divider = Color(UIColor.separator)                        // System separator

    static let shadowLight = Color.black.opacity(0.1)
    static let shadowMedium = Color.black.opacity(0.2)
    static let shadowDark = Color.black.opacity(0.3)
}

class Colors {
    func categoryColors (catEnum: categoryEnum) -> Color {
        switch catEnum {
        case .Food:
            AppColors.catFood
        case .Transport:
            AppColors.catTransport
        case .Entertainment:
            AppColors.catEntertainment
        case .Shopping:
            AppColors.catShopping
        case .Utilities:
            AppColors.catUtilities
        case .Other:
            AppColors.catOther
        case .None:
            AppColors.bgTertiary
        }
    }
    func catagoryEmojis (catEnum: categoryEnum) -> String {
        switch catEnum {
        case .Food:
            return "🍔"
        case .Transport:
            return "🚗"
        case .Entertainment:
            return "🎬"
        case .Shopping:
            return "🛍️"
        case .Utilities:
            return "💡"
        case .Other:
            return "📦"
        case .None:
            return ""
        }
    }
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
        
        if percentage > 1.0 {
            return AppColors.danger
        } else if percentage > 0.95 {
            return AppColors.warning
        } else if percentage > 0.80 {
            return AppColors.info
        } else {
            return AppColors.success
        }
    }
    
    static func statusText(used: Double, total: Double, currency: currencyEnum) -> String {
        let percentage = used / total
        
        if percentage > 1.0 {
            let over = (used - total)
            return "Over Budget by \(currency == .USD ? "$" : "₺")\(String(format: "%.2f", over))"
        } else if percentage > 0.95 {
            return "Budget Warning - Almost at limit!"
        } else if percentage > 0.80 {
            return "\(Int(percentage * 100))% of budget used"
        } else if percentage == 0 {
            return "Start tracking your spending."
        }
        else {
            let remaining = total - used
            return "Budget OK - \(currency == .USD ? "$" : "₺")\(String(format: "%.2f", remaining)) remaining"
        }
    }
}
