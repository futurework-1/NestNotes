import SwiftUI

struct NoteColorCircle: View {
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 29, height: 29)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: isSelected ? 1 : 0)
            )
            .onTapGesture {
                action()
            }
            .animation(.easeInOut(duration: 0.15), value: isSelected)
    }
}

#Preview {
    HStack(spacing: 16) {
        NoteColorCircle(color: Color("redNoteColor"), isSelected: false) {}
        NoteColorCircle(color: Color("blueNoteColor"), isSelected: true) {}
        NoteColorCircle(color: Color("greenNoteColor"), isSelected: false) {}
    }
    .padding()
    .background(Color.black)
}
