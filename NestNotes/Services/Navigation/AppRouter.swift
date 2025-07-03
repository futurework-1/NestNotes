//
//  AppRouter.swift
//  NestNotes
//
//  Created by Адам Табиев on 03.07.2025.
//

import Foundation

/// Управляет маршрутами экранов приложения.
/// Отвечает за навигацию между основными экранами и вкладками.

final class AppRouter: ObservableObject {
    
    /// Текущий основной экран приложения
    @Published var currentMainScreen: AppMainScreen = .splash
    
    /// Стек экранов вкладки "Notes"
    @Published var notesRoute: [NotesScreen] = []
    
    /// Стек экранов вкладки "Tips"
    @Published var tipsRoute: [TipsScreen] = []
    
    /// Стек экранов вкладки "Settings"
    @Published var settingsRoute: [SettingsScreen] = []
    
}

// MARK: - Основные экраны приложения

/// Основные экраны приложения.
/// Определяет глобальную навигацию между основными разделами.
enum AppMainScreen {
    case splash        // Экран загрузки приложения
    case tabbar        // Главный экран с табами
}

// MARK: - Экраны вкладки "Notes"

/// Экраны вкладки "Notes".
enum NotesScreen {
    case main
}

// MARK: - Экраны вкладки "Tips"

/// Экраны вкладки "Tips".
enum TipsScreen {
    case main
}

// MARK: - Экраны вкладки "Settings"

/// Экраны вкладки "Settings".
enum SettingsScreen {
    case main
}

// MARK: - Вкладки приложения с индексами

/// Вкладки приложения с индексами.
/// Определяет порядок и индексы вкладок в TabBar.
enum AppTabScreen {
    case note
    case tips
    case settings
    
    /// Индекс для выбранной вкладки.
    var selectedTabScreenIndex: Int {
        switch self {
        case .note:
            return 0
        case .tips:
            return 1
        case .settings:
            return 2
        }
    }
}
