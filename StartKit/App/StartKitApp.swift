import SwiftUI

@main
struct StartKitApp: App {
    @State private var container = DIContainer()
    @State private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(container)
                .environment(appState)
        }
    }
}
