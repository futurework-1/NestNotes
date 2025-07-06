import SwiftUI

struct TipsMainView: View {
    /// Роутер для навигации
    @EnvironmentObject private var appRouter: AppRouter
    /// Настройка таббара
    @EnvironmentObject private var tabbarService: TabbarService
    
    @State private var isTipToggleOn: Bool = false
        
    let facts: [String] = [
        "Some birds build their nests from petals, moss, and even animal fur. They do it so gently, as if weaving a home for the soul",
        "Some birds build their nests from petals, moss, and even animal fur. They do it so gently, as if weaving a home for the soul",
        "Some birds build their nests from petals, moss, and even animal fur. They do it so gently, as if weaving a home for the soul",
        "Some birds build their nests from petals, moss, and even animal fur. They do it so gently, as if weaving a home for the soul",
        "Some birds build their nests from petals, moss, and even animal fur. They do it so gently, as if weaving a home for the soul"
    ]
    
    var body: some View {
        @ObservedObject var appRouter = appRouter
        
        NavigationStack(path: $appRouter.tipsRoute) {
            ZStack {
                
                // Фон
                Image("Bg_v2")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack(alignment: .center, spacing: 0) {
                    
                    // Заголовок представления
                    Text("Mia’s Tips")
                        .font(.customFont(font: .regular, size: 35))
                        .foregroundColor(.white)
                        .shadow(color: .violet1, radius: 0, x: 0, y: 6)
                        .padding(.top, 50)
                        .padding(.bottom, 18)
                    
                    // Вьюшка включения голоса цыплёнка
                    HStack {
                        Text("Mia's voice")
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                        
                        Spacer()
                        
                        Toggle("", isOn: $isTipToggleOn)
                            .labelsHidden()
                            .tint(Color("violet2"))
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 14)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color.violet1)
                    }
                    
                    ScrollView {
                        
                        ZStack {
                            Image("chiken")
                                .resizable()
                                .ignoresSafeArea()
                                .scaledToFill()
                            
                            Image("speechBalloons")
                                .resizable()
                                .ignoresSafeArea()
                                .scaledToFill()
                                .frame(width: 120, height: 120, alignment: .center)
                                .offset(x: -80, y: 50)
                        }
                        
                        ForEach(facts, id: \.self) { fact in
                            Text(fact)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                                .padding(15)
                                .background {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .fill(Color.violet1)
                                }
                        }
                        
                        
                    }
                    .padding(.bottom, 168)
                    .padding(.top, 8)
                    
                }
                .padding(.horizontal, 20)
                
                
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TipsMainView()
        .environmentObject(AppRouter())
        .environmentObject(TabbarService())
}
