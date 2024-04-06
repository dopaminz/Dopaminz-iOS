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
                    Image(asset: .Home)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                }
            HistoryView(store: store.scope(state: \.history, action: \.history))
                .tabItem {
                    Image(asset: .History)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                }
            ProfileView(store: store.scope(state: \.profile, action: \.profile))
                .tabItem {
                    Image(asset: .Profile)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                }
        }
        .tint(.basicBlack)
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.gray)
            UITabBar.appearance().backgroundColor = .white.withAlphaComponent(0.8)
            UITabBar.appearance().isTranslucent = true
        }
    }
}
