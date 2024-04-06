//
//  AuthFeature.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import ComposableArchitecture
import DesignSystem

@Reducer
public struct AuthFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        var loginButton: Bool = false
        @Presents var login: LoginFeature.State?
        var path: StackState<Path.State> = .init()
        var authTitle: String = "로그인이 필요한 페이지입니다."
        var authSubTitle: String = "땅땅땅의 모든 기능을 이용하시려면"
        var authLastTitle: String = " 회원가입 후 로그인 해주세요."
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
        case signUP(SignUPFeature)
        case signUPInfo(SignUPInfoFeature)
        case profile(ProfileFeature)
        case web(WebFeature)
        case selectCategory(SelectCategoryFeature)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none

            case let .path(action):
                switch action {
                case .element(id: _, action: .login(.presntSignUP)):
                    state.path.append(.signUP(.init()))
               
                case .element(id: _, action: .signUP(.presentSignUPInfo)):
                    state.path.append(.signUPInfo(.init()))
                    
                case .element(id: _, action: .signUP(.presentWebTermsofServiceAgreed)):
                    state.path.append(.web(.init(url: "https://pale-target-4fe.notion.site/63d653fabc1c4c2bb9bd9ded5ea67aa5?pvs=4")))
                    
                case .element(id: _, action: .signUP(.presentPolicyAgreedWeb)):
                    state.path.append(.web(.init(url: "https://pale-target-4fe.notion.site/1996be282ec54e6182af2d49fbd08757?pvs=4")))
                    
                case .element(id: _, action: .signUPInfo(.presentSelectCategory)):
                    state.path.append(.selectCategory(.init()))
                default:
                    break
               
                }
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

