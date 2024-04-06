//
//  HistoryView.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

public struct HistoryView: View {
    @Bindable var store: StoreOf<HistoryFeature>
    
    public init(
        store: StoreOf<HistoryFeature>
    ) {
        self.store = store
    }
    
    public var body: some View {
        Text(store.title)
    }
}
