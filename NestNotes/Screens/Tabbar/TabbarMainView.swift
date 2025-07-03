//
//  TabbarMainView.swift
//  NestNotes
//
//  Created by Адам Табиев on 03.07.2025.
//

import SwiftUI

struct TabbarMainView: View {
    
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
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                TabbarBottomView(selectedTab: $selectedTab, tabbarHeight: tabbarHeight)
            }
            .padding(.bottom, 60)
            .padding(.horizontal, 56)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    TabbarMainView()
}
