import SwiftUI

/// Шрифты Bungee
/// Перечисление содержит все доступные варианты шрифта Bungee.

enum CustomFont: String {
    /// Обычный вариант шрифта
    case regular = "Bungee-Regular"
}

extension Font {
    /// Создает кастомный шрифт Bungee с указанным стилем и размером
    ///
    /// - Parameters:
    ///   - font: Стиль шрифта из перечисления CustomFont
    ///   - size: Размер шрифта в пунктах
    /// - Returns: SwiftUI.Font с указанным стилем и размером
    ///
    /// Примеры использования:
    /// ```swift
    /// Text("Заголовок")
    ///     .font(.customFont(font: .bold, size: 24))
    /// ```
    static func customFont(font: CustomFont, size: CGFloat) -> SwiftUI.Font {
        .custom(font.rawValue, size: size)
    }
}
