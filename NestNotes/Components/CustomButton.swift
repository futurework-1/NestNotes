import SwiftUI

struct CustomButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Text(title)
            .font(.customFont(font: .regular, size: 25))
            .shadow(color: .violet1, radius: 0, x: 0, y: 4)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.yellow)
            .cornerRadius(16)
            .opacity(isEnabled ? 1.0 : 0.2)
            .onTapGesture {
                if isEnabled {
                    action()
                }
            }
            .animation(.easeInOut(duration: 0.15), value: isEnabled)
    }
}

#Preview {
    VStack(spacing: 20) {
        CustomButton(title: "Save", isEnabled: true, action: {})
        CustomButton(title: "Save", isEnabled: false, action: {})
    }
    .padding()
    .background(Color.black)
}

