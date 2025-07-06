import SwiftUI

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Text(title)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(isSelected ? Color("violet2") : Color("violet1"))
            )
            .opacity(isSelected ? 1.0 : 0.9)
            .onTapGesture {
                action()
            }
            .animation(.easeInOut(duration: 0.15), value: isSelected)
    }
}

#Preview {
    ZStack {
        Image("Bg_v2")
            .resizable()
            .ignoresSafeArea()
            .scaledToFill()
        
        VStack(spacing: 16) {
            CategoryButton(title: "💡Idea", isSelected: false) {}
            CategoryButton(title: "✅ Task", isSelected: true) {}
            CategoryButton(title: "✨ Task", isSelected: true) {}
        }
        .padding()
        .scaleEffect(2)
    }
}

