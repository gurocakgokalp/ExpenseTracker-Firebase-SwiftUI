//
//  AuthRouterView.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 21.11.2025.
//

import SwiftUI
import FirebaseAuth

struct AuthRouterView: View {
    @State private var isLoggedIn: Bool = false
    @State private var hasCheckedAuth: Bool = false
    var body: some View {
        Group {
            if !hasCheckedAuth {
                ProgressView()
            } else {
                if isLoggedIn {
                    ContentView().tint(.green)
                        .transition(.opacity.combined(with: .scale))
                } else {
                    WelcomeView().tint(.green)
                        .transition(.opacity.combined(with: .scale))
                }
            }
        }.onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                withAnimation(.easeInOut(duration: 0.35)) {
                    if user != nil {
                        isLoggedIn = true
                    } else {
                        isLoggedIn = false
                    }
                    hasCheckedAuth = true
                }
            }
        }
    }
}

#Preview {
    AuthRouterView()
}
