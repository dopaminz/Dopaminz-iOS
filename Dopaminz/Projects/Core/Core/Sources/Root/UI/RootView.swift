//
//  RootView.swift
//  Core
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

public struct RootView: View {
    @Bindable var store: StoreOf<RootFeature>
    
    public init(
        store: StoreOf<RootFeature>
    ) {
        self.store = store
    }
   public var body: some View {
       VStack {
           MainTabView(store: store.scope(state: \.mainTab, action: \.mainTab))
       }
    }
}


