//
//  AllExpensesView.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 22.11.2025.
//

import SwiftUI

struct AllExpensesView: View {
    @StateObject var viewModel = MainViewModel()
    @State var sheet1: Bool = false
    @State var sheet2: Bool = false
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text("Descending by Date")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(AppColors.textSecondary)
                                Spacer()
                                Text("All Time")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(AppColors.textSecondary)
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
                                ForEach(viewModel.expenses) { expence in
                                    ExpenseListView(currencyEnum: viewModel.currency, expense: expence)
                                }
                            }
                            
                        }
                        .padding(AppTypography.lg)
                    }
                }
            }
        }.navigationTitle("My Expenses")
            .padding()
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.listenCurrency()
                viewModel.listenBudget()
                viewModel.fetchTotalExpenses()
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("1")
                        sheet1 = true
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheet2 = true
                        print("2")
                    } label: {
                        Image(systemName: "calendar")
                    }
                }
            }
            .sheet(isPresented: $sheet1) {
                VStack {
                    Text("Sort")
                }
                    .padding()
                    .presentationDetents([.height(250)])
            }
            .sheet(isPresented: $sheet2) {
                VStack {
                    Text("Filter")
                }
                    .padding()
                    .presentationDetents([.height(250)])
            }
    }
}

#Preview {
    AllExpensesView()
}
