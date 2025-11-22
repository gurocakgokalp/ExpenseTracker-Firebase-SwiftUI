//
//  SignUpView.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 20.11.2025.
//

import SwiftUI

struct SignUpView: View {
    @State private var isSecured: Bool = false
    @State private var isLoading: Bool = false
    @State private var isSheeting: Bool = false
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    private var title: String = "Password"
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                    VStack(alignment: .leading) {
                        Text("Username")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(AppColors.textSecondary)
                            .padding(.leading).offset(y: 15)
                        
                        ZStack(alignment: .trailing) {
                            TextField(title, text: $username, prompt: Text("Gurocak")).padding().bold().font(.system(size: 25)).padding(.trailing, 32)
                        }.textInputAutocapitalization(.never)
                    }
                }.frame(height: 50)
                    .padding()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(AppColors.textSecondary)
                            .padding(.leading).offset(y: 15)
                        
                        ZStack(alignment: .trailing) {
                            TextField(title, text: $email, prompt: Text("ex@ex")).padding().bold().font(.system(size: 25)).padding(.trailing, 32)
                                .keyboardType(.emailAddress)
                        }.textInputAutocapitalization(.never)
                    }
                }.frame(height: 50)
                    .padding()
                ZStack {
                    RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                    VStack(alignment: .leading) {
                        Text("Password")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(AppColors.textSecondary)
                            .padding(.leading).offset(y: 15)
                        ZStack(alignment: .trailing) {
                            Group {
                                if isSecured {
                                    SecureField(title, text: $password, prompt: Text("****")).padding().bold().font(.system(size: 25))
                                        .textInputAutocapitalization(.never)
                                } else {
                                    TextField(title, text: $password, prompt: Text("****")).padding().bold().font(.system(size: 25))
                                        .textInputAutocapitalization(.never)
                                }
                            }.padding(.trailing, 32)
                            
                            Button {
                                isSecured.toggle()
                            } label: {
                                Image(systemName: isSecured == false ? "eye.slash" : "eye").foregroundStyle(AppColors.textPrimary)
                            }.padding(.trailing, 14)
                            
                            
                        }
                    }
                }.frame(height: 50)
                    .padding()
                Button {
                    isLoading = true
                    Task {
                        await FirebaseAuthProcess().signUpFirebase(username: username, email: email, password: password)
                        isLoading = false
                        if FirebaseAuthProcess().errMessage != nil {
                            print("hata var kakkkdes: \(FirebaseAuthProcess().errMessage)")
                        }
                        
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(Color(.secondarySystemGroupedBackground))
                        ZStack {
                            Text("Sign Up").fontWeight(.heavy).foregroundStyle(.green).opacity(isLoading == true ? 0 : 1)
                            ProgressView().opacity(isLoading == false ? 0 : 1)
                        }
                        .padding()
                    }.padding()
                    
                }
            }.navigationTitle("Hey there!")
                .navigationSubtitle("Sign up.")
                .navigationBarTitleDisplayMode(.large)
                .alert("Oops!", isPresented: $isSheeting) {
                    
                } message: {
                    Text(FirebaseAuthProcess().errMessage ?? "something went wrong")
                }

                
        }
    }
}

#Preview {
    SignUpView()
}
