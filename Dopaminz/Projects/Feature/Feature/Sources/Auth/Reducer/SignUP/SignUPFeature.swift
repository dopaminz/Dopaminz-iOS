//
//  SignUPFeature.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct SignUPFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        var webLoading: Bool = false
        var isAllAgreed: Bool = false
        var isTermsofServiceAgreed: Bool = false
        var isServicePolicyAgreed: Bool = false
        var isMarketingInformationAgreed: Bool = false
        var isPrivacyPolicyAgreed: Bool = false
        var isConfirmButtonActivated: Bool = false
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case didTapAgreeAllPolicy
        case didTapAgreeServicePolicy
        case didTapAgreePrivacyPolicy
        case presentSignUPInfo
        case presentPolicyAgreedWeb
        case presentWebTermsofServiceAgreed
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            
            case .binding(_):
                return .none
            case .didTapAgreeAllPolicy:
                state.isAllAgreed.toggle()
                state.isTermsofServiceAgreed = state.isAllAgreed
                state.isServicePolicyAgreed = state.isAllAgreed
                state.isMarketingInformationAgreed = state.isAllAgreed
                state.isConfirmButtonActivated = state.isAllAgreed
                return .none
                
            case .didTapAgreeServicePolicy:
                state.isTermsofServiceAgreed.toggle()
                state.isAllAgreed = state.isTermsofServiceAgreed && state.isServicePolicyAgreed
                state.isConfirmButtonActivated = state.isAllAgreed
                return .none
                
                
            case .didTapAgreePrivacyPolicy:
                state.isServicePolicyAgreed.toggle()
                state.isAllAgreed = state.isTermsofServiceAgreed && state.isServicePolicyAgreed
                state.isConfirmButtonActivated = state.isAllAgreed
                return .none
                
            case .presentSignUPInfo:
                return .none
                
            case .presentWebTermsofServiceAgreed:
                return .none
                
            case .presentPolicyAgreedWeb:
                return .none
            }
        }
    }
}

