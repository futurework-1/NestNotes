import SwiftUI

/// Модель элемента таббара
struct TabbarItem {
    let icon: String
    let title: String
}

struct TabbarBottomView: View {
    
    @Binding var selectedTab: AppTabScreen
    let tabbarHeight: CGFloat
    
    /// Элементы таббара с иконками и заголовками
    private let tabbarItems: [TabbarItem] = [
        TabbarItem(icon: "🥚", title: "NOTES"),
        TabbarItem(icon: "📚", title: "TIPS"),
        TabbarItem(icon: "⚙️", title: "SETTINGS")
    ]
    
    /// Расчет ширины элемента таббара
    private var tabWidth: CGFloat {
        (UIScreen.main.bounds.width - (56 * 2)) / CGFloat(tabbarItems.count)
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(tabbarItems.indices, id: \.self) { index in
                VStack(alignment: .center, spacing: 0) {
                    Text(tabbarItems[index].icon)
                        .font(.customFont(font: .regular, size: 25))
                    
                    if selectedTab.selectedTabScreenIndex == index {
                        Text(tabbarItems[index].title)
                            .font(.customFont(font: .regular, size: 11))
                            .foregroundStyle(.white)
                    }
                }
                .frame(width: tabWidth)
                .background {
                    if selectedTab.selectedTabScreenIndex == index {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.violet2)
                            .frame(width: tabWidth - 10, height: tabbarHeight - 10)
                    }
                }
                .onTapGesture {
                    withAnimation {
                        switch index {
                        case 1: selectedTab = .tips
                        case 2: selectedTab = .settings
                        default: selectedTab = .note
                        }
                    }
                }
            }
        }
        .frame(height: tabbarHeight)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.violet1.opacity(0.9))
        }
    }
}

#Preview {
    TabbarMainView()
        .environmentObject(AppRouter())
        .environmentObject(TabbarService())
}
