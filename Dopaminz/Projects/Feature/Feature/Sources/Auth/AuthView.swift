//
//  AuthView.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct AuthView: View {
    @Bindable var store: StoreOf<AuthFeature>
    
    public init(
        store: StoreOf<AuthFeature>
    ) {
        self.store = store
    }
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


