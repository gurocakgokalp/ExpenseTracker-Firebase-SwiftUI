//
//  DashboardView.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 19.11.2025.
//

import SwiftUI



struct DashboardView: View {
    var budgetUsed = 2962.4
    //var budgetTotal = 3000.0
    @StateObject var viewModel = MainViewModel()
    @State var isSheet: Bool = false
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
                                    Text("\(viewModel.currency == .USD ? "$" : "₺")\(String(format: "%.2f", viewModel.totalSpending))")
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundColor(AppColors.textPrimary)
                                        .transition(.opacity)
                                        .animation(.smooth, value: viewModel.totalSpending)
                                    Text("/ \(viewModel.currency == .USD ? "$" : "₺")\(String(format: "%.2f", viewModel.budget))")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(AppColors.textSecondary)
                                }
                                
                                
                                let statusColor = BudgetStatusColor.color(used: viewModel.totalSpending, total: viewModel.budget)
                                
                                ProgressView(value: viewModel.totalSpending / viewModel.budget)
                                    .tint(statusColor).transition(.slide).animation(.spring(.smooth), value: viewModel.totalSpending)
                                
                                Text(BudgetStatusColor.statusText(used: viewModel.totalSpending, total: viewModel.budget, currency: viewModel.currency))
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(statusColor).transition(.opacity)
                                    .padding(.top, 5).animation(.smooth(), value: viewModel.totalSpending)
                                
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
                                    NavigationLink(destination: AllExpensesView()) {
                                        Text("View All")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(AppColors.textTertiary)
                                    }
                                    
                                }
                                /*
                                Text(Date().formatted(date: .abbreviated, time: .omitted)).font(.system(size: 20, weight: .bold))
                                */
                                
                                //
                                //prefix ilk 3
                                //suffix son 3
                                //
                                if viewModel.expenses.isEmpty {
                                    HStack(spacing: 10) {
                                        Image(systemName: "plus.circle.fill")
                                                        .font(.system(size: 20))
                                                        .foregroundColor(AppColors.textSecondary)
                                                        .opacity(0.5)
                                        VStack(alignment: .leading,spacing: 4) {
                                                        Text("No expenses recorded")
                                                            .font(.system(size: 20, weight: .bold))
                                                            .foregroundColor(AppColors.textPrimary)
                                                        
                                                        Text("Add your first expense to get started")
                                                .font(.system(size: 16, weight: .semibold))
                                                            .foregroundColor(AppColors.textSecondary)
                                                    }
                                    }.onTapGesture {
                                        print("basildi")
                                        NotificationCenter.default.post(name: NSNotification.Name("firstExpense"), object: nil)
                                    }
                                    
                                } else {
                                    ForEach(viewModel.expenses.prefix(5)) { expence in
                                        ExpenseListView(currencyEnum: viewModel.currency, expense: expence)
                                    }
                                }
                                
                            }
                            .padding(AppTypography.lg)
                        }
                        //Spacer(minLength: 20)
                        //DailyAvgTrendView(viewModel: viewModel)
                        
                    }
                }.scrollIndicators(.hidden)
                    .refreshable {
                        //
                    }
            }.padding()
                .navigationTitle("Expense Tracker")
                .navigationSubtitle(Date().formatted(date: .numeric, time: .omitted))
                .onAppear{
                    viewModel.listenCurrency()
                    viewModel.listenBudget()
                    viewModel.fetchTotalExpenses()
                }
                
        }
    }
}

#Preview {
    DashboardView()
}
