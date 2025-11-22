//
//  SignInUpView.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 20.11.2025.
//

import SwiftUI

struct WelcomeView: View {
    @State private var currentOpacity: Double = 40
    @State private var isLoading: Bool = false
    var body: some View {
        NavigationStack {
            VStack (spacing: 10) {
                VStack {
                    Circle().frame(width: 250)
                        .opacity(0.3)
                        .foregroundStyle(.green)
                        .ignoresSafeArea().blur(radius: currentOpacity)
                        .offset(y: 190)
                        .onAppear {
                                        withAnimation(
                                            .easeInOut(duration: 2)
                                            .repeatForever(autoreverses: true)
                                        ) {
                                            currentOpacity = 60
                                        }
                                    }
                    Image(systemName: "chart.bar.fill").foregroundStyle(AppColors.textSecondary)
                    Text("Expense Tracker").fontWeight(.heavy).font(.system(size: 34)).shadow(radius: 20)
                    Text("Track your spending, take control of your finances.").fontWeight(.semibold).font(.system(size: 17)).multilineTextAlignment(.center)
                        .foregroundStyle(.gray)
                }.offset(y: -70)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(AppColors.bgSecondary)
                        .shadow(radius: 30)
                        .opacity(0.7)
                        .frame(height: 200)
                    VStack {
                        Button {
                            //
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20).fill(AppColors.bgPrimary)
                                    .frame(height: 50)
                                ZStack {
                                    Text("Get Started").bold().foregroundStyle(AppColors.textPrimary).opacity(isLoading == true ? 0 : 1)
                                    ProgressView().opacity(isLoading == false ? 0 : 1)
                                }
                                .padding()
                            }
                            
                        }
                        NavigationLink(destination: <#T##() -> View#>, label: <#T##() -> View#>)
                        Button {
                            //
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20).fill(AppColors.bgPrimary)
                                    .frame(height: 50)
                                ZStack {
                                    Text("Already have account? Sign In").fontWeight(.heavy).foregroundStyle(.green.opacity(0.7)).opacity(isLoading == true ? 0 : 1)
                                    ProgressView().opacity(isLoading == false ? 0 : 1)
                                }
                                .padding()
                            }
                            
                        }
                    }.padding()
                }.offset(y: 150)
            }
                //.offset(y: -300)
        }
    }
}

#Preview {
    WelcomeView()
}
