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
    @State private var budgetString: String = "0"
    @State private var accountCurrency: currencyEnum = .USD
    @State private var isPresented: Bool = false
    @State private var isLoading: Bool = false
    @State private var username: String = ""
    @State private var email: String = ""
    @StateObject var viewModel = MainViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    ScrollView {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                                VStack(alignment: .leading) {
                                    ZStack {
                                        Text("Account")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(AppColors.textSecondary)
                                        
                                    }
                                    Spacer(minLength: 10)
                                    ZStack {
                                        HStack {
                                            Text(username).font(.system(size: 27, weight: .bold))
                                                .foregroundColor(AppColors.textPrimary)
                                            
                                            Spacer()
                                        }.opacity(username == "" ? 0 : 1)
                                        ProgressView().opacity(username == "" ? 1 : 0)
                                    }
                                    HStack {
                                        Text(email).font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(.gray).opacity(email == "" ? 0 : 1)
                                        ProgressView().opacity(email == "" ? 1 : 0)
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
                                                budgetString = String(format: "%.2f", viewModel.budget)
                                                isPresented = true
                                            }
                                    }
                                    Spacer(minLength: 10)
                                    HStack {
                                        VStack {
                                            Text("\(viewModel.currency == .USD ? "$" : "₺") \(String(format: "%.2f", viewModel.budget))").font(.system(size: 27, weight: .bold))
                                                .foregroundColor(AppColors.textPrimary)
                                        }
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
                                        Picker("", selection: $viewModel.currency) {
                                            ForEach(currencyEnum.allCases, id: \.self) { categorySecim in
                                                Text(categorySecim.rawValue).foregroundStyle(AppColors.textSecondary).bold().font(.system(size: 24, weight: .semibold))
                                            }
                                        }.pickerStyle(.navigationLink)
                                            .onChange(of: viewModel.currency) { oldValue, newValue in
                                                isLoading = true
                                                Task {
                                                    await FirebaseUserSProcess().saveCurrency(newValue)
                                                    isLoading = false
                                                }
                                            }
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
                                FirebaseAuthProcess().signOut()
                            }
                        }
                    }
                }.padding()
                    .overlay {
                        if isLoading {
                            Color(.black).opacity(0.4).ignoresSafeArea()
                            ProgressView()
                        }
                    }
                    .navigationTitle("Settings")
                    .sheet(isPresented: $isPresented) {
                        VStack(spacing: 20) {
                            Text("Edit Budget")
                                .font(.title2)
                                .bold()

                            TextField("Enter your budget", text: $budgetString)
                                .keyboardType(.decimalPad)
                                .padding()

                            HStack {
                                Button("Cancel") {
                                    budgetString = String(format: "%.2f", viewModel.budget)
                                    isPresented = false
                                }

                                Spacer()

                                Button("Save") {
                                    if let newBudget = Double(budgetString) {
                                        isLoading = true
                                        Task {
                                            await FirebaseUserSProcess().updateBudget(newBudget: newBudget)
                                            isLoading = false
                                        }
                                    }
                                    isPresented = false
                                }
                            }
                            .padding()
                        }
                        .padding()
                        .presentationDetents([.height(250)])
                    }

                    .onAppear{
                        self.email = FirebaseUserSProcess().getEmail()
                        viewModel.listenBudget()
                        viewModel.listenCurrency()
                        Task {
                            self.username = await FirebaseUserSProcess().getUsername()
                            
                        }
                    }
            }
        }
    }
}

#Preview {
    SettingsView()
}
