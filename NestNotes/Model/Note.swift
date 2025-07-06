import Foundation
import SwiftUI

/// Модель заметки
struct Note: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var category: NoteCategory
    var color: NoteColor
    var comment: String?
    var isCompleted: Bool
    var createdAt: Date
    var completedAt: Date?
}

/// Категории заметок
enum NoteCategory: String, Codable, CaseIterable, Identifiable {
    case idea = "Idea"
    case task = "Task"
    case dream = "Dream"
    
    var id: String { rawValue }
}

/// Цвета заметок, привязанные к asset catalog
enum NoteColor: String, Codable, CaseIterable, Identifiable {
    case green = "greenNoteColor"
    case red = "redNoteColor"
    case yellow = "yellowNoteColor"
    case blue = "blueNoteColor"
    case black = "blackNoteColor"
    case white = "whiteNoteColor"
    case violet = "violetNoteColor"
    
    var id: String { rawValue }
    
    /// SwiftUI Color для использования в UI
    var color: Color {
        Color(rawValue)
    }
}
