//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 21.11.2025.
//
import Foundation
import Combine
import FirebaseFirestore

struct Expense: Identifiable ,Codable {
    @DocumentID var id: String?
    var description: String?
    var amountString: String
    var category: categoryEnum
    var date: Date
    
    enum CodingKeys: String, CodingKey {
            case id
            case description
            case amountString = "expenseAmountString"
            case category = "category"
            case date
        }
}

