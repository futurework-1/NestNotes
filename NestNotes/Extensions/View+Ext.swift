import SwiftUI

extension View {
    /// Скрывает клавиатуру, отправляя команду прекращения первого резидента.
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
