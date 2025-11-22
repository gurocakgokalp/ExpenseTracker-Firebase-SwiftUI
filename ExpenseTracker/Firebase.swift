//
//  Firebase.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 21.11.2025.
//
import FirebaseFirestore
import FirebaseAuth
import Foundation

class FirebaseAuthProcess {
    let defaultMonthlyBudget: Double = 3000.0
    let defaultCurrency: String = "USD"
    var errMessage: String?
    func signUpFirebase(username: String, email: String, password: String) async {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            print("User successfully created.")
            let userUid = Auth.auth().currentUser!.uid
            let db = Firestore.firestore()
            try await db.collection("users").document(userUid).setData(["username": username, "monthlyBudget": defaultMonthlyBudget,"Currency": defaultCurrency])
            print("User datas (username) successfully saved.")
        } catch let error {
            print("something went wrong:")
            print(error.localizedDescription)
            self.errMessage = error.localizedDescription
        }
        
    }
    
    func logInFirebase(email: String, password: String) async {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            print("Logged in.")
        } catch let err {
            print("something went wrong:")
            print(err.localizedDescription)
            self.errMessage = err.localizedDescription
        }
    }
    
    func signOut() {
            do {
                try Auth.auth().signOut()
            } catch let error{
            print(error.localizedDescription)
        }
    }
    
}

class FirebaseExpenseProcess {
    func saveExpense(expense: Expense) async {
        let userUid = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        do {
            try await db.collection("users").document(userUid).collection("expenses").addDocument(data: ["expenseAmountString": expense.amountString, "date": expense.date, "description": expense.description ?? "", "category": expense.category.rawValue])
        } catch let err {
            print(err.localizedDescription)
        }
        
    }
}

class FirebaseUserSProcess {
    
    func getUsername() async -> String {
        let userUid = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        do {
                let document = try await db.collection("users").document(userUid).getDocument()
                
                if let data = document.data(),
                   let username = data["username"] as? String {
                    return username
                } else {
                    print("Username not found in document")
                    return "Unknown"
                }
            } catch {
                print("Error fetching username: \(error.localizedDescription)")
                return "Unknown"
            }
    }
    
    func getEmail() -> String {
        return (Auth.auth().currentUser?.email)!
    }
    
    func updateBudget(newBudget: Double) async {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        do {
            try await db.collection("users").document(userUid).updateData([
                "monthlyBudget": newBudget
            ])
            print("update")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveCurrency(_ currency: currencyEnum) async {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        do {
            try await db.collection("users").document(userUid).updateData([
                "Currency": currency.rawValue
            ])
            print("update")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    

}

