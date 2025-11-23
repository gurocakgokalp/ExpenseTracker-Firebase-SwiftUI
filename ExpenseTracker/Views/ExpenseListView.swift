//
//  ExpenseListView.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 21.11.2025.
//

import SwiftUI
import FirebaseFirestore

enum buttonState {
    case idle
    case loading
    case success
}

struct ExpenseListView: View {
    @StateObject var viewModel = MainViewModel()
    @State var currencyEnum: currencyEnum
    @State var currCategoryEnum: categoryEnum = .None
    
    @State private var buttonState: buttonState = .idle
    
    @State var isPresented: Bool = false
    @State private var isDateToday: Bool = true
    @State private var isLoading: Bool = false
    @State private var newCurrent: String = ""
    var expense: Expense
    init(currencyEnum: currencyEnum, expense: Expense) {
        self.currencyEnum = currencyEnum
        self.expense = expense
    }
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10, ).frame(width: 35,height: 35)
                        .foregroundStyle(AppColors.bgPrimary)
                        .overlay(RoundedRectangle(cornerRadius: 10, ).stroke(Colors().categoryColors(catEnum: expense.category),lineWidth: 0.3))
                    Text(Colors().catagoryEmojis(catEnum: expense.category)).font(.system(size: 13))
                }
                
                VStack (alignment: .leading) {
                    Text(expense.description ?? "").font(.system(size: 20, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                        .lineLimit(1)
                    Text(expense.category.rawValue).font(.system(size: expense.description == "" ? 20 : 14, weight: expense.description == "" ? .bold : .semibold))
                        .foregroundColor(expense.description == "" ? AppColors.textPrimary : AppColors.textSecondary).offset(y: expense.description == "" ? -8 : 0)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(viewModel.currency == .USD ? "$" : "₺")\(expense.amountString)").foregroundStyle(.red).fontWeight(.bold)
                    Text(expense.date.formatted(date: .numeric, time: .shortened)).foregroundStyle(.gray).font(.system(size: AppTypography.tiny))
                }
            }
            //Custom seperator başlangıç
            //RoundedRectangle(cornerRadius: 20 ).frame(height: 0.7).foregroundStyle(.gray).opacity(0.5)
            //Custom seperator bitiş
        }.onAppear{
            viewModel.listenCurrency()
        }.onTapGesture {
            print(expense.description ?? "No desc")
            isPresented = true
        }.sheet(isPresented: $isPresented) {
            VStack(alignment: .leading) {
                //Spacer(minLength: 10)
                Button {
                    isPresented = false
                } label: {
                    Text("Cancel")
                }.buttonStyle(.glass)
                    .disabled(isLoading)

                if expense.description != "" {
                    HStack {
                        Text(expense.description ?? "")
                            .font(.system(size: 27, weight: .heavy))
                            .foregroundStyle(AppColors.textPrimary)
                        Spacer()
                    }
                    Text(expense.category.rawValue)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(AppColors.textSecondary)
                } else {
                    HStack {
                        Text(expense.category.rawValue)
                            .font(.system(size: 27, weight: .heavy))
                            .foregroundStyle(AppColors.textPrimary)
                        Spacer()
                    }
                }
                Text(expense.date.formatted(date: .numeric, time: .shortened)).font(.system(size: 12, weight: .semibold)).foregroundStyle(AppColors.textTertiary)
                Spacer(minLength: 20)
                ZStack {
                    RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                    VStack(alignment: .leading) {
                        Text("Amount")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(AppColors.textSecondary)
                        HStack {
                            Text("\(viewModel.currency == .USD ? "$" : "₺")").font(.system(size: 27, weight: .bold))
                                .foregroundColor(AppColors.textPrimary)
                            
                            TextField(text: $newCurrent, prompt: Text("Enter here")) {
                                
                            }.font(.system(size: 27, weight: .bold))
                                .foregroundColor(AppColors.textPrimary)
                                .keyboardType(.decimalPad)
                        }
                    }.padding(AppTypography.lg)
                }.frame(height: 30)
                Spacer(minLength: 10)
                Button {
                    if buttonState == .idle {
                        buttonState = .loading
                        Task {
                            await FirebaseExpenseProcess().deleteExpense(expense: expense)
                            buttonState = .success
                            isPresented = false
                        }
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                        ZStack {
                            //Text("Delete").bold().foregroundStyle(.red).opacity(buttonState == .idle ? 1 : 0)
                            Image(systemName: buttonState == .idle ? "trash" : (buttonState == .loading ? "hourglass" : "checkmark.circle")).contentTransition(.symbolEffect(.replace.byLayer)).foregroundStyle(.red)
                        }
                        
                        .padding()
                    }.frame(height: 30)
                        .animation(.smooth, value: buttonState)
                        .disabled(buttonState != .idle)
                    
                }
                //Spacer(minLength: 10)
            }
            .onAppear {
                newCurrent = expense.amountString
                currCategoryEnum = expense.category
            }
            .padding()
            .presentationDetents([.height(300)])
        }
    }
}

#Preview {
    //ExpenseListView(currencyEnum: .USD)
}
