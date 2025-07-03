//
//  ContentView.swift
//  NestNotes
//
//  Created by Адам Табиев on 03.07.2025.
//

import SwiftUI

struct RootView: View {
    
    /// Роутер для навигации
    @EnvironmentObject private var appRouter: AppRouter
    
    var body: some View {
        Group {
            switch appRouter.currentMainScreen {
            case .splash:
                SplashMainView()
            case .tabbar:
                TabbarMainView()
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(AppRouter())
}

