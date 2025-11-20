//
//  SettingsView.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 19.11.2025.
//

import SwiftUI

enum currencyEnum: String, CaseIterable {
    case USD = "USD"
    case TL = "TL"
}

enum pieTimePeriod: String, CaseIterable {
    case Weekly = "Weekly"
    case Monthly = "Monthly"
    case AllTime = "All Times"
}

struct SettingsView: View {
    @State private var budgetString: String = "3000.0"
    @State private var accountCurrency: currencyEnum = .USD
    @State private var isPresented: Bool = false
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                            VStack(alignment: .leading) {
                                Text("Account")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(AppColors.textSecondary)
                                Spacer(minLength: 10)
                                HStack {
                                    Text("Gökalp Gürocak").font(.system(size: 27, weight: .bold))
                                        .foregroundColor(AppColors.textPrimary)
                                    Spacer()
                                }
                                HStack {
                                    Text("ggurocak58@gmail.com").font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.gray)
                                    Spacer()
                                }
                            }.padding(AppTypography.lg)
                        }
                        Spacer(minLength: 20)
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Budget")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(AppColors.textSecondary)
                                    Spacer()
                                    Text("Edit")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(AppColors.textTertiary)
                                        .onTapGesture {
                                            isPresented = true
                                        }
                                }
                                Spacer(minLength: 10)
                                HStack {
                                    Text("$ \(budgetString)").font(.system(size: 27, weight: .bold))
                                        .foregroundColor(AppColors.textPrimary)
                                    /*
                                    TextField(text: $budgetString, prompt: Text("3000.00")) {
                                        
                                    }.font(.system(size: 27, weight: .bold))
                                        .foregroundColor(AppColors.textPrimary)
                                        .keyboardType(.decimalPad)
                                     */
                                }
                            }.padding(AppTypography.lg)
                        }
                        Spacer(minLength: 20)
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                            VStack(alignment: .leading) {
                                Text("App Preferences")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(AppColors.textSecondary)
                                Spacer(minLength: 10)
                                HStack {
                                    Text("Currency")
                                        .font(.system(size: 24, weight: .semibold))
                                        .foregroundColor(AppColors.textPrimary)
                                    Picker("", selection: $accountCurrency) {
                                        ForEach(currencyEnum.allCases, id: \.self) { categorySecim in
                                            Text(categorySecim.rawValue).foregroundStyle(AppColors.textSecondary).bold().font(.system(size: 24, weight: .semibold))
                                        }
                                    }.pickerStyle(.navigationLink)
                                    Spacer()
                                }
                            }.padding(AppTypography.lg)
                        }
                        Spacer(minLength: 20)
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Log Out").font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.red)
                                    Spacer()
                                    Image(systemName: "rectangle.portrait.and.arrow.right").foregroundStyle(.red)
                                }
                            }.padding(AppTypography.lg)
                        }.onTapGesture {
                           //logout
                        }
                    }
                }
            }.padding()
                .navigationTitle("Settings")
                .alert("Edit Budget", isPresented: $isPresented) {
                    TextField(text: $budgetString, prompt: Text("3000.00")) {
                        
                    }.font(.system(size: 27, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                        .keyboardType(.decimalPad)
                }
        }
    }
}

#Preview {
    SettingsView()
}
