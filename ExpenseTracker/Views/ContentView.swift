//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Gökalp Gürocak on 19.11.2025.
//

import SwiftUI

enum tabState {
    case Dashboard
    case AddExpense
    case Analytics
    case Settings
}

struct ContentView: View {
    @State private var selectedTab: tabState = .Dashboard
    @State private var shouldLock: Bool = false
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                Tab("Dashboard", systemImage: "chart.pie.fill", value: .Dashboard) {
                    DashboardView()
                }.disabled(shouldLock)
                Tab("Add", systemImage: "plus.circle.fill", value: .AddExpense) {
                    AddExpenseView().onReceive(NotificationCenter.default.publisher(for: Notification.Name("askim"))) { _ in
                        print("info geldi")
                        selectedTab = .Dashboard
                    }
                }
                Tab("Analytics", systemImage: "chart.bar.fill", value: .Analytics) {
                    AnalyticsView()
                }.disabled(shouldLock)
                Tab("Settings", systemImage: "gear", value: .Settings) {
                    SettingsView()
                }.disabled(shouldLock)
            }.tint(.green)
                
            
        }.onReceive(NotificationCenter.default.publisher(for: Notification.Name("lock"))) { _ in
            shouldLock = true
        }.onReceive(NotificationCenter.default.publisher(for: Notification.Name("unlock"))) { _ in
            shouldLock = false
        }
    }
}

#Preview {
    ContentView()
}
