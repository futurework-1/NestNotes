import SwiftUI

struct CustomAlert: View {
    let title: String
    let message: String
    let onCancel: () -> Void
    let onClear: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 24)
            Text(message)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            Divider().background(Color.white.opacity(0.2))
            Button(action: onCancel) {
                Text("Cancel")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
            }
            Divider().background(Color.white.opacity(0.2))
            Button(action: onClear) {
                Text("Clear")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color("violet1"))
        )
        .padding(.horizontal, 40)
        .shadow(radius: 20)
    }
}

#Preview {
    CustomAlert(
        title: "Clear All Notes",
        message: "⚠️ Are you sure? This will permanently delete all your notes. This action cannot be undone.",
        onCancel: {},
        onClear: {}
    )
}
