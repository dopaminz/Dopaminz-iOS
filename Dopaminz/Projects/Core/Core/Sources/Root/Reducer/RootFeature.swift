//
//  RootFeature.swift
//  Core
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct RootFeature{
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        var mainTab: MainTabBarFeature.State = .init()
    }
    
    public enum Action {
        case mainTab(MainTabBarFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            
            }
        }
        Scope(state: \.mainTab, action: /Action.mainTab) {
            MainTabBarFeature()
        }
    }
}

