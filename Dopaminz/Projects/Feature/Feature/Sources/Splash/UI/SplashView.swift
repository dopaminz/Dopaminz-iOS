//
//  SplashView.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture

public struct SplashView: View {
    @Bindable var store: StoreOf<SplashFeature>

    public init(
        store: StoreOf<SplashFeature>
    ) {
        self.store = store
    }
    
    public var body: some View {
        Text("splash")
    }
}