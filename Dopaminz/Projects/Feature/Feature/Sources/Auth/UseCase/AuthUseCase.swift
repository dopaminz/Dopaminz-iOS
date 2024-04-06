//
//  AuthUseCase.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Model
import DiContainer

public struct AuthUseCase: AuthUseCaseProtocol  {
  
    private let repository: AuthRepositoryProtocol
    
    public init(
        repository: AuthRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    public func requsetSignUP(
        userName: String,
        password: String,
        nickName: String,
        completion: @escaping () -> Void
    ) async {
        return await repository.requsetSignUP(
            userName: userName,
            password: password, nickName: nickName,
            completion: completion
        )
    }
    
    public func requsetLogin(
        userName: String,
        password: String,
        completion: @escaping () -> Void
    ) async {
        return await repository.requsetLogin(
            userName: userName,
            password: password,
            completion: completion
        )
    }
    
    public func requsetProfile(completion: @escaping () -> Void) async {
        return await repository.requsetProfile(completion: completion)
    }
}

extension AuthUseCase: DependencyKey {
    public static let liveValue: AuthUseCase = {
           let authRepository = DIContainer.container.resolve(AuthRepositoryProtocol.self) ?? DefaultAuthRepository()
           return AuthUseCase(repository: authRepository)
       }()
}

public extension DependencyValues {
    var authUseCase: AuthUseCaseProtocol {
        get { self[AuthUseCase.self] }
        set { self[AuthUseCase.self] = newValue as! AuthUseCase}
    }
}


