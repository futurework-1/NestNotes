import SwiftUI

extension NoteCategory {
    var emoji: String {
        switch self {
        case .idea: return "💡"
        case .task: return "✅"
        case .dream: return "✨"
        }
    }
}

struct NoteCardView: View {
    let note: Note
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(note.category.emoji) \(note.category.rawValue)")
                    .font(.system(size: 14, weight: .bold))
                    .padding(8)
                    .background(Color.black.opacity(0.25))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                Spacer()
            }
            Text(note.title)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(5)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(note.color.color)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.9), lineWidth: 2)
                )
        )
        .onTapGesture {
            onTap?()
        }
    }
}

#Preview {
    NoteCardView(note: Note(
        id: UUID(),
        title: "Create a cozy corner at home for reading and journaling.",
        category: .idea,
        color: .blue,
        comment: nil,
        isCompleted: false,
        createdAt: Date(),
        completedAt: nil
    ))
    .padding()
    .background(.black)
}
