//
//  ViewModel.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 21.11.2025.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine

class MainViewModel: ObservableObject {
    @Published var budget: Double = 0
    @Published var currency: currencyEnum = .USD
    @Published var totalSpending: Double = 0
    @Published var expenses: [Expense] = []
    @Published var categoryExpenses: [String: Double] = [:]
    @Published var categoryChart: [(category: String, amount: Double)] = []
    
    func listenBudget() {
        if Auth.auth().currentUser != nil {
            let userUid = Auth.auth().currentUser!.uid
            let db = Firestore.firestore()
            
            db.collection("users").document(userUid).addSnapshotListener { snapshot, error in
                guard error == nil else {
                    print(error?.localizedDescription ?? "Unknown Error")
                    return
                }
                
                if let data = snapshot?.data(),
                   let budget = data["monthlyBudget"] as? Double {
                    self.budget = budget
                }
            }
        }
    }
    
    
    func listenCurrency() {
        if Auth.auth().currentUser != nil {
            let userUid = Auth.auth().currentUser!.uid
            let db = Firestore.firestore()
            
            db.collection("users").document(userUid).addSnapshotListener { snapshot, error in
                guard error == nil else {
                    print(error?.localizedDescription ?? "Unknown Error")
                    return
                }
                
                if let data = snapshot?.data(),
                    let currencyString = data["Currency"] as? String,
                    let currency = currencyEnum(rawValue: currencyString) {
                    self.currency = currency
                }
            }
        }
    }
    
    func fetchAllCategoryExpenses(){
        if Auth.auth().currentUser != nil {
            let userUid = Auth.auth().currentUser!.uid
            let db = Firestore.firestore()
            
            for category in categoryEnum.allCases {
                db.collection("users")
                    .document(userUid)
                    .collection("expenses")
                    .whereField("category", isEqualTo: category.rawValue)
                    .order(by: "date", descending: true).addSnapshotListener { snapshot, err in
                        guard err == nil else {
                            print(err?.localizedDescription ?? "Unknown Error")
                            return
                        }
                        
                        let expenses = snapshot?.documents.compactMap { doc in
                            try? doc.data(as: Expense.self)
                        } ?? []
                        
                        //reduce arraydeki elemanları toplar reduce(0) 0 dan başlayarak
                        let total = expenses.reduce(0) { sum, expense in
                            let amount = Double(expense.amountString) ?? 0
                            return sum + amount
                        }
                        Task {
                            self.categoryExpenses[category.rawValue] = total
                            self.updateChartData()
                        }
                    }
            }
            
        }
    }
    
    private func updateChartData() {
        let chartData = categoryExpenses
            .map { (category: $0.key, amount: $0.value) }
            .filter { $0.amount > 0 }  // 0 olan categories'i gösterme
            .sorted { $0.amount > $1.amount }  // Büyükten küçüğe sırala
            
        self.categoryChart = chartData
    }
    
    func fetchTotalExpenses() {
        if Auth.auth().currentUser != nil {
            let userUid = Auth.auth().currentUser!.uid
            let db = Firestore.firestore()
            
            db.collection("users").document(userUid).collection("expenses")
                .order(by: "date", descending: true)
                .addSnapshotListener { snapshot, error in
                    guard error == nil else {
                        print(error?.localizedDescription ?? "Unknown Error")
                        return
                    }
                    
                    //expenseleri "Expense" modeline gore çekioyrum
                    let expenses = snapshot?.documents.compactMap { doc in
                        try? doc.data(as: Expense.self)
                    } ?? []
                    
                    //reduce arraydeki elemanları toplar reduce(0) 0 dan başlayarak
                    let total = expenses.reduce(0) { sum, expense in
                        let amount = Double(expense.amountString) ?? 0
                        return sum + amount
                    }
                    
                    Task {
                        self.expenses = expenses
                        self.totalSpending = total
                    }
                }
        }
    }
}
