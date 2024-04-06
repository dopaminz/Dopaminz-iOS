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
            AppView(
                store:
                    Store(
                        initialState: AppFeature.State(),
                        reducer: {
                            AppFeature()
                                ._printChanges()
                        }
                    )
            )
        }
    }
    
    private func registerDependencies() {
        AppDIContainer.shared.registerDependencies()
    }
}
