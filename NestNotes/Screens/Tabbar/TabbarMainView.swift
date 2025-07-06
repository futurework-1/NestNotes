import SwiftUI

struct TabbarMainView: View {
    /// Настройка таббара
    @EnvironmentObject private var tabbarService: TabbarService
    /// Текущая выбранная вкладка
    @State private var selectedTab: AppTabScreen = .note
    /// Высота таббара
    private let tabbarHeight: CGFloat = 68
    
    var body: some View {
        ZStack(alignment: .center) {
            Group {
                switch selectedTab {
                case .note:
                    NoteMainView()
                case .tips:
                    TipsMainView()
                case .settings:
                    SettingsMainView()
                }
            }
            
            // Таббар поверх контента
            if tabbarService.isTabbarVisible {
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    TabbarBottomView(selectedTab: $selectedTab, tabbarHeight: tabbarHeight)
                }
                .padding(.bottom, 60)
                .padding(.horizontal, 56)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    TabbarMainView()
        .environmentObject(AppRouter())
        .environmentObject(TabbarService())
}
