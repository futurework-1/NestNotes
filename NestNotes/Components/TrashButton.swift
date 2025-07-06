import SwiftUI

struct TrashButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image("trashIcon")
                .resizable()
                .scaledToFit()
                .frame(height: 42)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TrashButton(action: {})
        .scaleEffect(8)
        .environmentObject(AppRouter())
}
