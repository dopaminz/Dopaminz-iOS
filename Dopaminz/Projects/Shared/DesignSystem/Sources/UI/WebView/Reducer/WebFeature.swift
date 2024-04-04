//
//  WebFeature.swift
//  DesignSystem
//
//  Created by 서원지 on 4/4/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct WebFeature {
    public init(){}
    
    @ObservableState
    public struct State: Equatable {
        var loading: Bool = false
        var url: String = ""
        
        public init(
            url: String
        ) {
            self.url = url
        }
        
    }
    
    public enum Action: Equatable {
        case didTapBackButton
        case startLoading
        case setLoading(Bool)
        case stopLoading
    
    }
    
    private enum CancelID {
      case id
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.mainQueue) var mainQueue
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .run { _ in
                    await self.dismiss()
                }
                
            case .startLoading:
                state.loading = true
                return .run { send in
                    try await Task.sleep(nanoseconds: 3_000_000_000)
                    await send(.setLoading(false))
                }
                .cancellable(id: CancelID.id)
                
                
            case .setLoading(let isLoading):
                state.loading = isLoading
                return .none
                
            case .stopLoading:
                state.loading = false
                return .cancel(id: CancelID.id)
            }
        }
    }
}


