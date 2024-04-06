//
//  AuthFeature.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct AuthFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        var loginButton: Bool = false
        @Presents var login: LoginFeature.State?
        var path: StackState<Path.State> = .init()
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case presentLogin
        case login(PresentationAction<LoginFeature.Action>)
        case closeBackButton
        case removePath
        case path(StackAction<Path.State, Path.Action>)
    }
    
    @Reducer(state: .equatable)
    public enum Path {
        case login(LoginFeature)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none

            case .path:
                return .none
                
            case .presentLogin:
                state.path.append(.login(.init()))
                return .none
                
            case .login:
                return .none
                
            case .removePath:
                state.path.removeLast()
                return .none
                
            case .closeBackButton:
                state.login = nil
                return .none
            }
        }
        .ifLet(\.$login, action: \.login) {
            LoginFeature()
        }
        .forEach(\.path, action: \.path)
    }
}

