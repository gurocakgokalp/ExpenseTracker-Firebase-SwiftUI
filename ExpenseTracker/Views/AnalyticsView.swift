//
//  AnalyticsView.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 19.11.2025.
//

import SwiftUI
import Charts

var catagoryChart = [
    (catagory: "Food", amount: 3500),
    (catagory: "Transport", amount: 600),
    (catagory: "Shopping", amount: 2750),
    (catagory: "Entertainment", amount: 900),
    (catagory: "Utilities", amount: 1900),
    (catagory: "Other", amount: 900),
]

var weeklyChart = [
    (catagory: "Mon", amount: 3500),
    (catagory: "Tue", amount: 600),
    (catagory: "Wed", amount: 2750),
    (catagory: "Thrs", amount: 900),
    (catagory: "Fri", amount: 1900),
    (catagory: "Sat", amount: 900),
    (catagory: "Sun", amount: 900)
]

struct AnalyticsView: View {
    @State var timePeriod: pieTimePeriod = .AllTime
    @StateObject var viewModel = MainViewModel()
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack {
                        if !viewModel.expenses.isEmpty {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Spending by Category")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(AppColors.textSecondary)
                                        Picker("", selection: $timePeriod) {
                                            ForEach(pieTimePeriod.allCases, id: \.self) { period in
                                                Text(period.rawValue).bold().foregroundStyle(.green)
                                            }
                                            }
                                        .pickerStyle(.navigationLink)
                                            //.frame(width: 150)
                                    }
                                    Spacer(minLength: 80)
                                    ZStack {
                                        Chart {
                                            ForEach(viewModel.categoryChart, id: \.category) { data in
                                                SectorMark(
                                                    angle: .value("Amount", data.amount),
                                                    innerRadius: .ratio(0.6),
                                                    angularInset: 1
                                                    )
                                                    .foregroundStyle(CategoryColor.color(for: data.category))
                                                    .cornerRadius(3)
                                                    .annotation(position: .overlay) {
                                                        //Text("\(viewModel.currency == .USD ? "$" : "₺")\(String(format: "%.0f", data.amount))")
                                                    //.font(.system(size: 10))
                                                //.bold()
                                                }
                                            }
                                        }.scaleEffect(2)
                                        Text("\(viewModel.currency == .USD ? "$" : "₺")\(String(format: "%.2f", viewModel.totalSpending))").fontWeight(.heavy).font(.system(size: 20))
                                    }
                                    Spacer(minLength: 80)
                                    Text("Details")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(AppColors.textSecondary)
                                    Spacer(minLength: 10)
                                    ForEach(viewModel.categoryChart, id: \.category) { data in
                                        HStack {
                                            Circle()
                                                .fill(CategoryColor.color(for: data.category))
                                                .frame(width: 12, height: 12)
                                            Text(data.category)
                                                .font(.system(size: 14, weight: .medium))
                                                .foregroundColor(AppColors.textPrimary)
                                                Spacer()
                                            Text("\(viewModel.currency == .USD ? "$" : "₺")\(String(format: "%.2f", data.amount))")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundColor(AppColors.textPrimary)
                                        }
                                        .padding(.vertical, 8)
                                    }
                                }.padding(AppTypography.lg)
                            }
                            //Spacer(minLength: 20)
                            //SmartInsightsView(viewModel: viewModel)
                            //Spacer(minLength: 20)
                            /*
                            ZStack {
                                RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                                VStack(alignment: .leading) {
                                    Text("Weekly Spending Trend")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(AppColors.textSecondary)
                                    Spacer(minLength: 20)
                                    Chart {
                                        ForEach(weeklyChart, id: \.catagory) { catagory in
                                            BarMark(x: .value("Weekly", catagory.catagory), y: .value("Spend", catagory.amount))
                                                .foregroundStyle(.green)
                                                .cornerRadius(10)
                                        }
                                    }
                                }.padding(AppTypography.lg)
                            }
                             */
                        } else {
                            VStack {
                                Spacer(minLength: 240)
                                Image(systemName: "chart.bar.fill").foregroundStyle(AppColors.textSecondary).font(.system(size: 29, weight: .bold))
                                Spacer(minLength: 10)
                                Text("No data yet.")
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundColor(AppColors.textSecondary)
                                Spacer()
                            }
                        }
                    }
                }.scrollIndicators(.hidden)
                    .refreshable {
                        //
                    }
            }.navigationTitle("Analytics")
                .padding()
                .onAppear{
                    viewModel.listenCurrency()
                    viewModel.fetchTotalExpenses()
                    viewModel.fetchAllCategoryExpenses()
            }
        }
    }
}

#Preview {
    AnalyticsView()
}
