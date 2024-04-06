//
//  AppFeature.swift
//  Dopaminz
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import Feature
import ComposableArchitecture


@Reducer
public struct AppFeature {
    public init() {}
    
    @ObservableState
    public enum State {
        case splash(SplashFeature.State)
        case root(RootFeature.State)
        
        public init() {
            self = .splash(SplashFeature.State())
        }
    }
    
    public enum Action {
        case presentSplashView
        case presentRootView
        
        case splash(SplashFeature.Action)
        case root(RootFeature.Action)
        
    }
    
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .splash(.presentRootView):
                return .none
             
            case .presentRootView:
                state = .root(.init())
                return .none
                
            default:
                return .none
            }
        }
        .ifCaseLet(\.splash, action:  \.splash) {
            SplashFeature()
        }
        .ifCaseLet(\.root, action: \.root) {
            RootFeature()
        }
    }
}

