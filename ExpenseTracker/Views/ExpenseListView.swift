//
//  ExpenseListView.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 21.11.2025.
//

import SwiftUI

struct ExpenseListView: View {
    @State var currencyEnum: currencyEnum
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
                    Text("\(currencyEnum == .USD ? "$" : "₺")\(expense.amountString)").foregroundStyle(.red).fontWeight(.bold)
                    Text(expense.date.formatted(date: .numeric, time: .shortened)).foregroundStyle(.gray).font(.system(size: AppTypography.tiny))
                }
            }
            //Custom seperator başlangıç
            //RoundedRectangle(cornerRadius: 20 ).frame(height: 0.7).foregroundStyle(.gray).opacity(0.5)
            //Custom seperator bitiş
        }
    }
}

#Preview {
    //ExpenseListView(currencyEnum: .USD)
}
