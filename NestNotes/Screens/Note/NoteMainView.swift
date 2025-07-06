import SwiftUI

struct NoteMainView: View {
    /// Роутер для навигации
    @EnvironmentObject private var appRouter: AppRouter
    /// Настройка таббара
    @EnvironmentObject private var tabbarService: TabbarService
    /// Заглушка для выбранного сегмента
    @State private var selectedSegment: SegmentedToggle.Segment = .inTheNest
    /// Массив заметок
    @State private var notes: [Note] = []
    /// Все заметки (для фильтрации)
    @State private var allNotes: [Note] = []
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    @State private var noteID: UUID = UUID()
    
    var body: some View {
        @ObservedObject var appRouter = appRouter
        
        NavigationStack(path: $appRouter.notesRoute) {
            ZStack {
                Image("Bg_v2")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack(alignment: .center, spacing: 0) {
                    Text("NOTES")
                        .font(.customFont(font: .regular, size: 35))
                        .foregroundColor(.white)
                        .shadow(color: .violet1, radius: 0, x: 0, y: 6)
                        .padding(.top, 50)
                    
                    SegmentedToggle(selection: $selectedSegment)
                        .padding(.top, 26)
                    
                    if notes.isEmpty {
                        VStack(spacing: 16) {
                            Image("crossMark")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 96)
                            Text("You don't have anything here yet..")
                                .font(.customFont(font: .regular, size: 18))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .shadow(color: .customYellow, radius: 0, x: 0, y: 1)
                        }
                        .padding(.top, 40)
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(notes) { note in
                                    NoteCardView(note: note) {
                                        noteID = note.id
                                        appRouter.notesRoute.append(.detailed)
                                    }
                                }
                            }
                            .padding(.top, 24)
                        }
                    }
                    Spacer(minLength: 0)
                    Button {
                        appRouter.notesRoute.append(.create)
                    } label: {
                        Text("ADD A NOTE")
                            .font(.customFont(font: .regular, size: 25))
                            .foregroundStyle(.white)
                            .shadow(color: .violet1, radius: 0, x: 0, y: 4)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background {
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.customYellow)
                            }
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 160)
                }
                .padding(.horizontal, 20)
                .onAppear {
                    allNotes = NoteUserDefaultsService.shared.fetchAll()
                    applyFilter()
                }
                .onChange(of: selectedSegment) { _ in
                    applyFilter()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: NotesScreen.self) { screen in
                switch screen {
                case .main:
                    NoteMainView()
                case .create:
                    NoteCreateView()
                case .detailed:
                    DetailedCardView(noteId: noteID)
                case .edit:
                    NoteEditView(note: NoteUserDefaultsService.shared.getNote(by: tabbarService.noteIDToEdit) ?? Note(
                        id: UUID(),
                        title: "Edit this note!",
                        category: .idea,
                        color: .blue,
                        comment: "Some comment",
                        isCompleted: false,
                        createdAt: Date(),
                        completedAt: nil
                    ))
                }
            }
        }
        .onAppear {
            allNotes = NoteUserDefaultsService.shared.fetchAll()
            applyFilter()
        }
    }
    
    private func applyFilter() {
        switch selectedSegment {
        case .inTheNest:
            notes = allNotes.filter { !$0.isCompleted }
        case .hatched:
            notes = allNotes.filter { $0.isCompleted }
        }
    }
}

#Preview {
    TabbarMainView()
        .environmentObject(AppRouter())
        .environmentObject(TabbarService())
}
