//
//  MainTabBarFeature.swift
//  Core
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Feature

@Reducer
public struct MainTabBarFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        var home: HomeFeature.State = .init()
        var history: HistoryFeature.State = .init()
        var profile: ProfileFeature.State = .init()
        
    }
    
    public enum Action {
        case home(HomeFeature.Action)
        case history(HistoryFeature.Action)
        case profile(ProfileFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            default:
                return .none
            }
        }
        Scope(state: \.home, action: /Action.home) {
            HomeFeature()
        }
        
        Scope(state: \.history, action: /Action.history) {
            HistoryFeature()
        }
        
        Scope(state: \.profile, action: /Action.profile) {
            ProfileFeature()
        }
    }
}

