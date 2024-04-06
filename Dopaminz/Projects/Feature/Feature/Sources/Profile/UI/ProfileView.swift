//
//  ProfileView.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

public struct ProfileView: View {
    @Bindable var store: StoreOf<ProfileFeature>
    
    public init(
        store: StoreOf<ProfileFeature>
    ) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Text(self.store.title)
        }
        
        
        .onAppear {
            if store.acessToken == "" {
                store.send(.presnetAuthFullScreen)
            }
        }
        
        .fullScreenCover(item: $store.scope(state: \.auth, action: \.auth)) { authStore in
            AuthView(store: authStore, backAction: {
                store.send(.closeBottomSheet)
            })
        }
    }
}


