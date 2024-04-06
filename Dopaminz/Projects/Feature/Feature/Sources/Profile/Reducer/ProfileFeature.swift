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
import DesignSystem

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
        case requsetProfile(completion: () -> Void)
        case logout
        case presentPolicyAgreedWeb
        case presentWebTermsofService
        case appearnickname
    }
    
    @Reducer(state: .equatable)
    public enum Path {
        case web(WebFeature)
    }
    
    @Dependency(AuthUseCase.self) var authUseCase
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .path:
                return .none
                    
                 
                
            
            case .auth:
                return .none
                
            case .presnetAuthFullScreen:
                let accessToken = (try? Keychain().get("AuthorizationToken")) ?? ""
                state.acessToken = accessToken
                if state.acessToken == "" {
                    state.auth = AuthFeature.State()
                }
                return .none
                
            case .closeBottomSheet:
                state.auth = nil
                return .none
                
            case .removePath:
                state.path.removeLast()
                return .none
                
            case .appearnickname:
//                let nickName = try? Keychain().get("nickname")
//                state.nickname = nickName ?? ""
                return .none
                
                
            case .logout:
                state.acessToken = ""
                try? Keychain().set(state.acessToken, key: "AuthorizationToken")
                let accessToken = (try? Keychain().get("AuthorizationToken")) ?? ""
                state.acessToken = accessToken
                if  state.acessToken == "" {
                    state.auth = AuthFeature.State()
                }
                return .none
            case let .requsetProfile(completion: completion):
                return .run { send in
                    await authUseCase.requsetProfile(completion: completion)
                }
                
            case .presentPolicyAgreedWeb:
                state.path.append(.web(.init(url: "https://pale-target-4fe.notion.site/63d653fabc1c4c2bb9bd9ded5ea67aa5?pvs=4")))
                return .none
                
                
            case .presentWebTermsofService:
                state.path.append(.web(.init(url: "https://pale-target-4fe.notion.site/1996be282ec54e6182af2d49fbd08757?pvs=4")))
                return .none
            }
        }
        .ifLet(\.$auth, action: \.auth) {
            AuthFeature()
        }
        .forEach(\.path, action: \.path)
    }
}



