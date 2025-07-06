import SwiftUI

struct BackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image("backIcon")
                .resizable()
                .scaledToFit()
                .frame(height: 42)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    BackButton(action: {})
        .scaleEffect(4)
}
