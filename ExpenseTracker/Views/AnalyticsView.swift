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
    @State var timePeriod: pieTimePeriod = .Monthly
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack {
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
                                        ForEach(catagoryChart, id: \.catagory) { catagory in
                                            SectorMark(angle: .value("Amount", catagory.amount), innerRadius: .ratio(0.6),angularInset: 1)
                                                .foregroundStyle(CategoryColor.color(for:catagory.catagory))
                                                .cornerRadius(3)
                                                .annotation(position: .overlay) {
                                                    Text("$\(catagory.amount)").font(.system(size: 5)).bold()
                                                }
                                        }
                                    }.scaleEffect(2)
                                    Text("$3400").fontWeight(.heavy).font(.system(size: 20))
                                }
                                
                                Spacer(minLength: 80)
                                VStack(alignment: .leading) {
                                    HStack {
                                        ForEach(["Food", "Transport", "Shopping","Entertainment"], id: \.self) { category in
                                            HStack {
                                                Circle()
                                                    .fill(CategoryColor.color(for: category))
                                                    .frame(width: 10, height: 10)
                                                
                                                Text(category)
                                                    .foregroundColor(AppColors.textPrimary).font(.system(size: 12))
                                            }
                                        }
                                    }
                                    HStack {
                                        ForEach(["Utilities", "Other"], id: \.self) { category in
                                            HStack {
                                                Circle()
                                                    .fill(CategoryColor.color(for: category))
                                                    .frame(width: 10, height: 10)
                                                
                                                Text(category)
                                                    .foregroundColor(AppColors.textPrimary)
                                                    .font(.system(size: 12))
                                            }
                                        }
                                    }
                                }
                            }.padding(AppTypography.lg)
                        }
                        Spacer(minLength: 20)
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
                                        Text("Daily average: $78.50").fontWeight(.semibold)
                                    }
                                    RoundedRectangle(cornerRadius: 20 ).frame(height: 0.7).foregroundStyle(.gray).opacity(0.5)
                                    HStack {
                                        Text("📈").font(.system(size: 20))
                                        Text("Spending trend: Slightly increasing ↑").fontWeight(.semibold)
                                    }
                                }
                            }.padding(AppTypography.lg)
                        }
                        Spacer(minLength: 20)
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
                    }
                }.scrollIndicators(.hidden)
            }.navigationTitle("Analytics")
                .padding()
        }
    }
}

#Preview {
    AnalyticsView()
}
