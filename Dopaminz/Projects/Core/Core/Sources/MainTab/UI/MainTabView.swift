//
//  MainTab.swift
//  Core
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import Feature

public struct MainTabView : View {
    @Bindable var store: StoreOf<MainTabBarFeature>

    public init(
        store: StoreOf<MainTabBarFeature>
    ) {
        self.store = store
    }
    
    public var body: some View {
        TabView {
            HomeView(store: store.scope(state: \.home, action: \.home))
                .tabItem {
                    Text("홈")
                }
            HistoryView(store: store.scope(state: \.history, action: \.history))
                .tabItem {
                    Text("내글")
                }
            ProfileView(store: store.scope(state: \.profile, action: \.profile))
                .tabItem {
                    Text("마이")
                }
        }
    }
}
