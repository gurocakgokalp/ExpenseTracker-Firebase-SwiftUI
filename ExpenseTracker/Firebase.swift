//
//  FirebaseProcess.swift
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

