//
//  LoginView.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

public struct LoginView: View {
    @Bindable var store: StoreOf<LoginFeature>
    var backAction: () -> Void = { }
    
    public init(
        store: StoreOf<LoginFeature>,
        backAction: @escaping () -> Void
        
    ) {
        self.store = store
        self.backAction = backAction
    }
    
    public var body: some View {
        VStack {
            Spacer()
                .frame(height: 17)
            
            NavigationBackButton(buttonAction: backAction)
            
            Spacer()
                .frame(height: 20)
            
            Text(store.title)
            
            Spacer()
        }
    }
}

