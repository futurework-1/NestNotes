//
//  NestNotesApp.swift
//  NestNotes
//
//  Created by Адам Табиев on 03.07.2025.
//

import SwiftUI

@main
struct NestNotes_V2App: App {
    
    /// Роутер для навигации
    @State private var appRouter = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appRouter)
                .dynamicTypeSize(.large)
                .background(.black)
        }
    }
}
