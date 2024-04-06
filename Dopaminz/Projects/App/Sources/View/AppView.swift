//
//  AppView.swift
//  Dopaminz
//
//  Created by 서원지 on 4/4/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import Shareds
import DesignSystem
import ComposableArchitecture
import Feature
import Core

struct AppView: View {
    @Bindable var store: StoreOf<AppFeature>

    
    
    var body: some View {
        SwitchStore(store) { state in
            switch state {
            case .splash:
                if let store = store.scope(state: \.splash, action: \.splash) {
                    SplashView()
                }
                   
            case .root:
                if let store = store.scope(state: \.root, action: \.root) {
                    RootView(store: store)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                store.send(.presentRootView)
            }
        }
    }
}

//#Preview {
//   HomeView()
//}
