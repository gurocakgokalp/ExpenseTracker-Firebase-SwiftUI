//
//  DailyAvgTrendView.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 22.11.2025.
//

import SwiftUI

struct DailyAvgTrendView: View {
    @State var viewModel: MainViewModel
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
            VStack(alignment: .leading) {
                
                if !viewModel.expenses.isEmpty {
                    HStack {
                        VStack {
                            Image(systemName: "chart.bar.fill").foregroundColor(AppColors.textSecondary)
                            Text("Daily Avg")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(AppColors.textSecondary).offset(y:7)
                        }
                        Text("No data yet.")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(AppColors.textPrimary)
                        Spacer()
                        VStack {
                            Image(systemName: "chart.line.uptrend.xyaxis").foregroundColor(AppColors.textSecondary)
                        }
                    }
                    
                } else {
                    HStack(alignment: .center) {
                        VStack {
                            Image(systemName: "chart.bar.fill").foregroundColor(AppColors.textSecondary)
                            Text("Daily Avg")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(AppColors.textSecondary).offset(y:7)
                        }
                        Text("\(viewModel.currency == .USD ? "$" : "₺")728.63")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(AppColors.textPrimary)
                        Spacer()
                        Text("+12%")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(AppColors.success)
                        VStack {
                            Image(systemName: "chart.line.uptrend.xyaxis").foregroundColor(AppColors.textSecondary)
                        }
                    }
                }
                
            }
            .padding(AppTypography.lg)
        }
    }
}

#Preview {
    //DailyAvgTrendView()
}
