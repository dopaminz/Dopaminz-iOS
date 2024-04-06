//
//  ProfileFeature.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import ComposableArchitecture
import KeychainAccess

@Reducer
public struct ProfileFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        var acessToken: String = ""
        var title: String = "Profile"
        var path: StackState<Path.State> = .init()
        @Presents var auth: AuthFeature.State?
        
    }
    
    public enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case auth(PresentationAction<AuthFeature.Action>)
        case presnetAuthFullScreen
        case closeBottomSheet
        case removePath
    }
    
    @Reducer(state: .equatable)
    public enum Path {
        case auth(AuthFeature)
        case login(LoginFeature)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .path(action):
                switch action {
                case .element(id: _, action: .auth):
                    state.path.append(.auth(.init()))
                 
                default:
                    break
                }
                return .none
                
            
            case .auth:
                return .none
                
            case .presnetAuthFullScreen:
                let accessToken = (try? Keychain().get("AuthorizationToken")) ?? ""
                state.acessToken = accessToken
                if accessToken == "" {
                    state.auth = AuthFeature.State()
                }
                return .none
                
            case .closeBottomSheet:
                state.auth = nil
                return .none
                
            case .removePath:
                state.path.removeLast()
                return .none
            }
        }
        .ifLet(\.$auth, action: \.auth) {
            AuthFeature()
        }
        .forEach(\.path, action: \.path)
    }
}


