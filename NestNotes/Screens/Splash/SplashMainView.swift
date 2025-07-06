import SwiftUI

struct SplashMainView: View {
    @EnvironmentObject private var appRouter: AppRouter
    
    @State private var scale: CGFloat = 0.2
    
    var body: some View {
        ZStack {
            Image("Bg_v2")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
            VStack(alignment: .center, spacing: 0) {
                Text("NEST")
                    .font(.customFont(font: .regular, size: 45))
                    .foregroundStyle(.white)
                    .shadow(color: .violet2, radius: 0, x: 0, y: 6)
                
                Text("Notes")
                    .font(.customFont(font: .regular, size: 45))
                    .foregroundStyle(.white)
                    .shadow(color: .violet2, radius: 0, x: 0, y: 6)
            }
            .scaleEffect(scale)
            .animation(.bouncy(duration: 1.0), value: scale)
            .onAppear {
                scale = 1.5
                Task {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    appRouter.currentMainScreen = .tabbar
                }
            }
        }
    }
}

#Preview {
    SplashMainView()
        .environmentObject(AppRouter())
}
