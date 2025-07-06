import SwiftUI

struct EditButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image("editIcon")
                .resizable()
                .scaledToFit()
                .frame(height: 42)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    EditButton(action: {})
        .scaleEffect(8)
        .environmentObject(AppRouter())
}
