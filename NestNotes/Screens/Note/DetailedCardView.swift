import SwiftUI

struct DetailedCardView: View {
    @Environment(\.dismiss) private var dismiss
    /// Роутер для навигации
    @EnvironmentObject private var appRouter: AppRouter
    /// Настройка таббара
    @EnvironmentObject private var tabbarService: TabbarService
    
    let noteId: UUID
    @State private var note: Note? = nil
    @State private var showDeleteAlert = false
    
    var body: some View {
        ZStack {
            Image("Bg_v2")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
            VStack(alignment: .center, spacing: 16) {
                HStack(alignment: .center, spacing: 5) {
                    BackButton {
                        dismiss()
                        tabbarService.isTabbarVisible = true
                    }
                    
                    Spacer(minLength: 0)
                    
                    EditButton {
                        tabbarService.noteIDToEdit = noteId
                        appRouter.notesRoute.append(.edit)
                    }
                    
                    TrashButton {
                        showDeleteAlert = true
                    }
                }
                .padding(.top, 50)
                
                if let note = note {
                    VStack(alignment: .center, spacing: 0) {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(note.title)
                                    .font(.customFont(font: .regular, size: 20))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 8)
                                    .frame(maxWidth: .infinity)
                                
                                Text("Category")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white.opacity(0.7))
                                
                                HStack(spacing: 8) {
                                    Text("\(note.category.emoji) \(note.category.rawValue)")
                                        .font(.system(size: 14, weight: .bold))
                                        .padding(8)
                                        .background(Color.black.opacity(0.25))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                
                                Text("Color")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white.opacity(0.7))
                                HStack(spacing: 8) {
                                    Circle()
                                        .fill(note.color.color)
                                        .frame(width: 29, height: 29)
                                }
                                
                                if let comment = note.comment, !comment.isEmpty {
                                    Text("Comment or link (optional)")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white.opacity(0.7))
                                    Text(comment)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding(.top, 2)
                                }
                            }
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.violet1.opacity(0.9))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.white.opacity(0.9), lineWidth: 2)
                                    )
                                    .padding(.top, 2)
                            )
                            
                            if note.isCompleted {
                                ZStack {
                                    Image("chiken")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                    Image("speechBalloons2")
                                        .resizable()
                                        .ignoresSafeArea()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120, alignment: .center)
                                        .offset(x: -80, y: 50)
                                }
                            }
                            
                        }
                        
                        Spacer(minLength: 0)
                        
                        VStack(alignment: .center, spacing: 0) {
                            CustomButton(
                                title: note.isCompleted ? "BACK THE NEST" : "MARK AS COMPLETED",
                                isEnabled: true
                            ) {
                                var updatedNote = note
                                updatedNote.isCompleted.toggle()
                                NoteUserDefaultsService.shared.update(note: updatedNote)
                                self.note = updatedNote
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 80)
                        }
                        
                    }
                } else {
                    Text("Note not found")
                        .font(.customFont(font: .regular, size: 35))
                        .foregroundColor(.white)
                        .shadow(color: .violet1, radius: 0, x: 0, y: 6)
                }
            }
            .padding(.horizontal, 20)
            .onTapGesture {
                hideKeyboard()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            tabbarService.isTabbarVisible = false
            note = NoteUserDefaultsService.shared.fetchAll().first(where: { $0.id == noteId })
        }
        .navigationBarBackButtonHidden()
        .overlay(
            Group {
                if showDeleteAlert {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    CustomAlert(
                        title: "Delete Note?",
                        message: "⚠️ Are you sure? This action cannot be undone.",
                        onCancel: { showDeleteAlert = false },
                        onClear: {
                            if let note = note {
                                NoteUserDefaultsService.shared.delete(note: note)
                                dismiss()
                            }
                            showDeleteAlert = false
                        }
                    )
                }
            }
        )
    }
}

#Preview {
    NavigationView {
        let mockNote = Note(
            id: UUID(),
            title: "Create a cozy corner at home for reading and journaling.",
            category: .idea,
            color: .blue,
            comment: "Maybe add a small plant and fairy lights ✨",
            isCompleted: false,
            createdAt: Date(),
            completedAt: nil
        )
        DetailedCardView(noteId: mockNote.id)
            .environmentObject(AppRouter())
            .environmentObject(TabbarService())
    }
}
