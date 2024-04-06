//
//  SplashFeature.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import ComposableArchitecture
import DesignSystem

@Reducer
public struct SplashFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        var splashImage: ImageAsset = .empty
    }
    
    public enum Action: Equatable {
        case presentRootView
    }
    
    @Dependency(\.continuousClock) var clock
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .presentRootView:
                return .none
            }
        }
    }
}

