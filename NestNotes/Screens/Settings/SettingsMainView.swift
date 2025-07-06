import SwiftUI
import WebKit

enum WebViewType {
    case privacyPolicy
    case aboutDeveloper
    
    var title: String {
        switch self {
        case .privacyPolicy: return "Privacy policy"
        case .aboutDeveloper: return "About developer"
        }
    }
}

struct WebViewScreen: View {
    let url: URL
    let type: WebViewType

    var body: some View {
        WebView(url: url)
            .navigationTitle(type.title)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct SettingsMainView: View {
    /// Роутер для навигации
    @EnvironmentObject private var appRouter: AppRouter
    /// Настройка таббара
    @EnvironmentObject private var tabbarService: TabbarService
    
    @State private var isNotificationsToggleOn: Bool = false
    @State private var showClearAlert = false
    @State private var showWebView = false
    @State private var webViewURL: URL? = nil
    @State private var webViewType: WebViewType = .privacyPolicy
    
    private let privacyPolicyURL = URL(string: "https://apple.com")
    private let aboutDeveloperURL = URL(string: "https://google.com")
    
    var body: some View {
        @ObservedObject var appRouter = appRouter
        
        NavigationStack(path: $appRouter.settingsRoute) {
            ZStack {
                
                // Фон
                Image("Bg_v2")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack(alignment: .center, spacing: 0) {
                    
                    // Заголовок представления
                    Text("Settings")
                        .font(.customFont(font: .regular, size: 35))
                        .foregroundColor(.white)
                        .shadow(color: .violet1, radius: 0, x: 0, y: 6)
                        .padding(.bottom, 40)
                    
                    
                    // Notifications
                    HStack(alignment: .center, spacing: 0) {
                        Text("Notifications")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                        Spacer()
                        Toggle("", isOn: $isNotificationsToggleOn)
                            .labelsHidden()
                            .tint(Color("violet2"))
                    }
                    .padding()
                    
                    Rectangle()
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1, alignment: .center)
                    
                    // Clear all notes
                    HStack(alignment: .center, spacing: 0) {
                        Text("Clear all notes")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                        Spacer()
                        Group {
                            Text("Clear")
                                .fontWeight(.heavy)
                                .foregroundColor(.red)
                                .font(.system(size: 18))
                            
                            Image(systemName: "chevron.right")
                                .resizable()
                                .foregroundColor(Color.white)
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .padding(.leading, 10)
                        }
                        .onTapGesture {
                            showClearAlert = true
                        }
                    }
                    .padding()
                    
                    Rectangle()
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1, alignment: .center)
                    
                    // Privacy Policy
                    HStack(alignment: .center, spacing: 0) {
                        Text("Privacy Policy")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                        Spacer()
                        Group {
                            Image(systemName: "chevron.right")
                                .resizable()
                                .foregroundColor(Color.white)
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                        }
                    }
                    .onTapGesture {
                        webViewURL = privacyPolicyURL
                        webViewType = .privacyPolicy
                        showWebView = true
                    }
                    .padding()
                    
                    Rectangle()
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1, alignment: .center)
                    
                    // About the Developer
                    HStack(alignment: .center, spacing: 0) {
                        Text("About the Developer")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                        Spacer()
                        Group {
                            Image(systemName: "chevron.right")
                                .resizable()
                                .foregroundColor(Color.white)
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                        }
                    }
                    .onTapGesture {
                        print("About the Developery")
                        webViewURL = aboutDeveloperURL
                        webViewType = .aboutDeveloper
                        showWebView = true
                    }
                    .padding()
                    
                    Rectangle()
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1, alignment: .center)
                    
                    Spacer()
                }
                .padding(.top, 50)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .overlay(
                Group {
                    if showClearAlert {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                        CustomAlert(
                            title: "Clear All Notes",
                            message: "⚠️ Are you sure? This will permanently delete all your notes. This action cannot be undone.",
                            onCancel: { showClearAlert = false },
                            onClear: {
                                NoteUserDefaultsService.shared.deleteAll()
                                showClearAlert = false
                            }
                        )
                    }
                }
            )
            .navigationDestination(isPresented: $showWebView) {
                if let url = webViewURL {
                    WebViewScreen(url: url, type: webViewType)
                        .onAppear { tabbarService.isTabbarVisible = false }
                        .onDisappear { tabbarService.isTabbarVisible = true }
                }
            }
            .onAppear {
                tabbarService.isTabbarVisible = true
            }
        }
    }
}

#Preview {
    SettingsMainView()
        .environmentObject(AppRouter())
        .environmentObject(TabbarService())
}

