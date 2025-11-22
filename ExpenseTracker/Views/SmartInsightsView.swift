//
//  SmartInsightsView.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 22.11.2025.
//

import SwiftUI

struct SmartInsightsView: View {
    @State var viewModel: MainViewModel
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
            VStack(alignment: .leading) {
                HStack {
                    Text("Smart Insights")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppColors.textSecondary)
                    Spacer()
                }
                Spacer(minLength: 10)
                VStack(alignment: .leading) {
                    HStack {
                        Text("💡").font(.system(size: 20))
                        Text("Daily average: \(viewModel.currency == .USD ? "$" : "₺")78.50").fontWeight(.semibold)
                    }
                    RoundedRectangle(cornerRadius: 20 ).frame(height: 0.7).foregroundStyle(.gray).opacity(0.5)
                    HStack {
                        Text("📈").font(.system(size: 20))
                        Text("Spending trend: Slightly increasing ↑").fontWeight(.semibold)
                    }
                }
            }.padding(AppTypography.lg)
        }
    }
}

#Preview {
    //SmartInsightsView()
}
