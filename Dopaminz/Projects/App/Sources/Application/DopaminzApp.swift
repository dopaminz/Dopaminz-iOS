import SwiftUI
import ComposableArchitecture


@main
struct DopaminzApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        registerDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func registerDependencies() {
        AppDIContainer.shared.registerDependencies()
    }
}
