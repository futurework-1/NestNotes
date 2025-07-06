import SwiftUI

@main
struct NestNotes_V2App: App {
    @StateObject private var appRouter = AppRouter()
    @StateObject private var tabbarService = TabbarService()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appRouter)
                .environmentObject(tabbarService)
                .dynamicTypeSize(.large)
                .background(.black)
        }
    }
}
