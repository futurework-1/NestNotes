import SwiftUI

struct NoteEditView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appRouter: AppRouter
    @EnvironmentObject private var tabbarService: TabbarService
    
    let note: Note
    
    let categoryNames = ["💡Idea", "✅ Task", "✨ Dream"]
    let noteColorNames: [String] = [
        "blueNoteColor",
        "redNoteColor",
        "violetNoteColor",
        "yellowNoteColor",
        "greenNoteColor",
        "whiteNoteColor",
        "blackNoteColor"
    ]
    
    @State private var noteText: String = ""
    let notePlaceholder: String = "Write your idea. thought or plan..."
    @State private var comment: String = ""
    let commentPlaceholder: String = "Comment or link (optional)..."
    @State private var selectedCategory: String = ""
    @State private var selectedNoteColor: String = ""
    
    var body: some View {
        ZStack {
            Image("Bg_v2")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    BackButton {
                        dismiss()
                        tabbarService.isTabbarVisible = true
                    }
                    
                    Text("EDIT NOTE")
                        .font(.customFont(font: .regular, size: 35))
                        .foregroundColor(.white)
                        .shadow(color: .violet1, radius: 0, x: 0, y: 6)
                        .padding(.leading, 24)
                    
                    Spacer(minLength: 0)
                }
                .padding(.top, 50)
                
                CustomTextEditor(text: $noteText, placeholder: notePlaceholder)
                    .padding(.top, 26)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Category")
                        .font(.system(size: 14, weight: .heavy))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(alignment: .center, spacing: 5) {
                        ForEach(categoryNames, id: \.self) { name in
                            CategoryButton(title: name, isSelected: selectedCategory == name) {
                                selectedCategory = name
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Choose egg color")
                        .font(.system(size: 14, weight: .heavy))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 8) {
                        ForEach(noteColorNames, id: \.self) { colorName in
                            NoteColorCircle(color: Color(colorName), isSelected: selectedNoteColor == colorName) {
                                selectedNoteColor = colorName
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 20)
                
                CustomTextEditor(text: $comment, placeholder: commentPlaceholder, minHeight: 40, maxHeight: 80)
                    .padding(.top, 20)
                
                Spacer(minLength: 0)
                
                CustomButton(
                    title: "SAVE",
                    isEnabled: !noteText.isEmpty && !selectedCategory.isEmpty && !selectedNoteColor.isEmpty
                ) {
                    guard let category = NoteCategory.allCases.first(where: { selectedCategory.contains($0.rawValue) }),
                          let color = NoteColor(rawValue: selectedNoteColor) else { return }
                    let updatedNote = Note(
                        id: note.id,
                        title: noteText,
                        category: category,
                        color: color,
                        comment: comment.isEmpty ? nil : comment,
                        isCompleted: note.isCompleted,
                        createdAt: note.createdAt,
                        completedAt: note.completedAt
                    )
                    NoteUserDefaultsService.shared.update(note: updatedNote)
                    dismiss()
                }
                .padding(.bottom, 80)
            }
            .padding(.horizontal, 20)
            .onTapGesture {
                hideKeyboard()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(action: { self.hideKeyboard() }) {
                        Text("Done")
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            noteText = note.title
            comment = note.comment ?? ""
            selectedCategory = categoryNames.first(where: { $0.contains(note.category.rawValue) }) ?? ""
            selectedNoteColor = note.color.rawValue
            tabbarService.isTabbarVisible = false
        }
    }
}

#Preview {
    NavigationView {
        NoteEditView(note: Note(
            id: UUID(),
            title: "Edit this note!",
            category: .idea,
            color: .blue,
            comment: "Some comment",
            isCompleted: false,
            createdAt: Date(),
            completedAt: nil
        ))
        .environmentObject(AppRouter())
        .environmentObject(TabbarService())
    }
}
