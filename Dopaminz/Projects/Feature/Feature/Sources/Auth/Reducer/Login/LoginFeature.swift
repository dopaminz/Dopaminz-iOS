//
//  LoginFeature.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct LoginFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        var title: String = "Login"
        var loginId: String = ""
        var password: String = ""
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case login(
            userName: String,
            password: String,
            completion: () -> Void
        )
        case presntSignUP
        case presntProfile
    }
    
    @Dependency(AuthUseCase.self) var authUseCase
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .login(userName: userName, password: password, completion:  completion):
                return .run { send in
                     await authUseCase.requsetLogin(
                        userName: userName,
                        password: password,
                        completion: completion
                     )
                }
                
            case .binding(_):
                return .none
                
            case .presntSignUP:
                return .none
                
            case .presntProfile:
                return .none
            }
        }

    }
}

