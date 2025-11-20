//
//  DashboardView.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 19.11.2025.
//

import SwiftUI

struct DashboardView: View {
    var budgetUsed = 2962.4
    var budgetTotal = 3000.0
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView{
                    VStack {
                        Spacer(minLength: 0)
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                            Image(systemName: "creditcard.fill").opacity(0.05).scaleEffect(6.5).foregroundStyle(.brown).offset(x:-90)
                            VStack(alignment: .leading) {
                                Text("This Month")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(AppColors.textSecondary)
                                
                                HStack(alignment: .center) {
                                    Text("$\(String(format: "%.2f", budgetUsed))")
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundColor(AppColors.textPrimary)
                                    Text("/ $\(String(format: "%.2f", budgetTotal))")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(AppColors.textSecondary)
                                }
                                
                                
                                let statusColor = BudgetStatusColor.color(used: budgetUsed, total: budgetTotal)
                                
                                ProgressView(value: budgetUsed / budgetTotal)
                                    .tint(statusColor)
                                
                                Text(BudgetStatusColor.statusText(used: budgetUsed, total: budgetTotal))
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(statusColor)
                                    .padding(.top, 5)
                                
                            }
                            .padding(AppTypography.lg)
                        }
                        Spacer(minLength: 20)
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Text("Recent Expenses")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(AppColors.textSecondary)
                                    Spacer()
                                    Text("View All")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(AppColors.textTertiary)
                                }
                                /*
                                Text(Date().formatted(date: .abbreviated, time: .omitted)).font(.system(size: 20, weight: .bold))
                                */
                                ForEach(1...3, id: \.self) { today in
                                    VStack {
                                        HStack {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 10, ).frame(width: 35,height: 35)
                                                    .foregroundStyle(AppColors.bgPrimary)
                                                    .overlay(RoundedRectangle(cornerRadius: 10, ).stroke(Color(AppColors.catFood),lineWidth: 0.3))
                                                Text("☕").font(.system(size: 13))
                                            }
                                            
                                            VStack (alignment: .leading) {
                                                Text("Coffee").font(.system(size: 20, weight: .bold))
                                                    .foregroundColor(AppColors.textPrimary)
                                                Text("Kahve Dunyasi").font(.system(size: 14, weight: .semibold))
                                                    .foregroundColor(AppColors.textSecondary)
                                            }
                                            Spacer()
                                            VStack(alignment: .trailing) {
                                                Text("$20.0").foregroundStyle(.red).fontWeight(.bold)
                                                Text(Date().formatted(date: .numeric, time: .shortened)).foregroundStyle(.gray).font(.system(size: AppTypography.tiny))
                                            }
                                        }
                                        RoundedRectangle(cornerRadius: 20 ).frame(height: 0.7).foregroundStyle(.gray).opacity(0.5)
                                    }
                                }
                                
                            }
                            .padding(AppTypography.lg)
                        }
                        Spacer(minLength: 20)
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                            VStack(alignment: .leading) {
                                
                                
                                HStack(alignment: .center) {
                                    VStack {
                                        Image(systemName: "chart.bar.fill").foregroundColor(AppColors.textSecondary)
                                        Text("Daily Avg")
                                            .font(.system(size: 10, weight: .semibold))
                                            .foregroundColor(AppColors.textSecondary).offset(y:7)
                                    }
                                    Text("$728.63")
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
                            .padding(AppTypography.lg)
                        }
                        
                    }
                }.scrollIndicators(.hidden)
            }.padding()
                .navigationTitle("Expense Tracker")
                .navigationSubtitle(Date().formatted(date: .numeric, time: .omitted))
        }
    }
}

#Preview {
    DashboardView()
}
