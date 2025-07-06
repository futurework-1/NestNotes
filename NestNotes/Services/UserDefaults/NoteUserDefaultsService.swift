import Foundation

/// Сервис для работы с заметками через UserDefaults
final class NoteUserDefaultsService {
    static let shared = NoteUserDefaultsService()
    private let notesKey = "notes"
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    /// Сохраняет новую заметку, добавляя её в массив
    func save(note: Note) {
        var notes = fetchAll()
        notes.append(note)
        saveAll(notes)
    }
    
    /// Возвращает все заметки
    func fetchAll() -> [Note] {
        guard let data = userDefaults.data(forKey: notesKey),
              let notes = try? JSONDecoder().decode([Note].self, from: data) else {
            return []
        }
        return notes
    }
    
    /// Удаляет заметку по id
    func delete(note: Note) {
        var notes = fetchAll()
        notes.removeAll { $0.id == note.id }
        saveAll(notes)
    }
    
    /// Обновляет заметку по id
    func update(note: Note) {
        var notes = fetchAll()
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
            saveAll(notes)
        }
    }
    
    /// Удаляет все заметки
    func deleteAll() {
        userDefaults.removeObject(forKey: notesKey)
    }
    
    /// Перезаписывает массив заметок
    private func saveAll(_ notes: [Note]) {
        if let data = try? JSONEncoder().encode(notes) {
            userDefaults.set(data, forKey: notesKey)
        }
    }
    
    /// Получить заметку по id
    func getNote(by id: UUID) -> Note? {
        fetchAll().first { $0.id == id }
    }
}
