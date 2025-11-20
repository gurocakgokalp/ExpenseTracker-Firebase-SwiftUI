//
//  AddExpenseView.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 19.11.2025.
//

import SwiftUI

enum categoryEnum: String, CaseIterable {
    case Food = "Food 🍔"
    case Transport = "Transport 🚗"
    case Entertainment = "Entertainment 🎬"
    case Shopping = "Shopping 🛍️"
    case Utilities = "Utilities 💡"
    case Other = "Other 📦"
    case None = "Select"
}

struct AddExpenseView: View {
    @State private var amountString: String = ""
    @State private var description: String = ""
    @State private var category: categoryEnum = .None
    @State private var date: Date = Date()
    @State private var isDateToday: Bool = true
    @State private var isLoading: Bool = false
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                            VStack(alignment: .leading) {
                                Text("Amount")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(AppColors.textSecondary)
                                HStack {
                                    Text("$").font(.system(size: 27, weight: .bold))
                                        .foregroundColor(AppColors.textPrimary)
                                    TextField(text: $amountString, prompt: Text("2500.00")) {
                                        
                                    }.font(.system(size: 27, weight: .bold))
                                        .foregroundColor(AppColors.textPrimary)
                                        .keyboardType(.decimalPad)
                                }
                            }.padding(AppTypography.lg)
                        }
                        Spacer(minLength: 20)
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Category")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(AppColors.textSecondary)
                                    Picker("", selection: $category) {
                                        ForEach(categoryEnum.allCases, id: \.self) { categorySecim in
                                            Text(categorySecim.rawValue).foregroundStyle(AppColors.textPrimary).bold().font(.system(size: 24, weight: .semibold))
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
                                    Text("Description")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(AppColors.textSecondary)
                                    Spacer()
                                    Text("Optional")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(AppColors.textTertiary)
                                }
                                HStack {
                                    TextField(text: $description, prompt: Text("It worth.")) {
                                        
                                    }.font(.system(size: 27, weight: .bold))
                                        .foregroundColor(AppColors.textPrimary)
                                }
                            }.padding(AppTypography.lg)
                        }
                        Spacer(minLength: 20)
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Date")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(AppColors.textSecondary)
                                    Spacer()
                                    Text("Right Now?").fontWeight(.semibold).foregroundStyle(isDateToday == true ? AppColors.textPrimary : .gray)
                                    Toggle(isOn: $isDateToday) {

                                    }.toggleStyle(.automatic)
                                        .frame(width: 60)
                                }
                                DatePicker("", selection: $date).datePickerStyle(.graphical).disabled(isDateToday)
                            }.padding(AppTypography.lg)
                        }
                        Spacer(minLength: 20)
                        Button {
                            if(category != .None && amountString != "") {
                                isLoading = true
                                NotificationCenter.default.post(name: NSNotification.Name("lock"), object: nil)
                            }
                            
                            
                            //NotificationCenter.default.post(name: NSNotification.Name("unlock"), object: nil)
                            //NotificationCenter.default.post(name: NSNotification.Name("askim"), object: nil)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                                ZStack {
                                    Text("OK").bold().foregroundStyle(.green).opacity(isLoading == true ? 0 : 1)
                                    ProgressView().opacity(isLoading == false ? 0 : 1)
                                }
                                .padding()
                            }
                            
                        }
                    }
                }.scrollIndicators(.hidden)
            }.padding()
            .navigationTitle("Add Expense")
            .disabled(isLoading)
        }
    }
}

#Preview {
    AddExpenseView()
}
