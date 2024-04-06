//
//  SignUPInfoFeature.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct SignUPInfoFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        var loginId: String = ""
        var password: String = ""
        var repassword: String = ""
        var nickName: String = ""
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case signUP(
            userName: String,
            password: String,
            nickName: String,
            completion: () -> Void
        )
        case presentSelectCategory
    }
    
    @Dependency(AuthUseCase.self) var authUseCase
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
                
                
            
            case let .signUP(userName: userName, password: password, nickName: nickName, completion: completion):
                return .run { send in
                    await authUseCase.requsetSignUP(
                        userName: userName,
                        password: password,
                        nickName: nickName,
                        completion: completion
                    )
                }
                
            case .presentSelectCategory:
                return .none
                
            }
        }
    }
}

