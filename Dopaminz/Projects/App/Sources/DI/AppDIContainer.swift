//
//  AppDIContainer.swift
//  Dopaminz
//
//  Created by 서원지 on 4/4/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import Swinject
import Networkings
import DiContainer
import Core
import Feature

public final class AppDIContainer {
    public static let shared: AppDIContainer = .init()
    
    private let diContainer: Container = DIContainer.container
    
    private init() {}

    public func registerDependencies() {
        registerRepositories()
        registerUseCases()
    }
    
    // MARK: - Use Cases
    private func registerUseCases() {
        registerAuthUseCase()
        registerHomeUseCase()
        
    }
    
    private func registerAuthUseCase() {
        diContainer.register(AuthUseCaseProtocol.self) { resolver in
            AuthUseCase(repository: resolver.resolve(AuthRepositoryProtocol.self)!)
        }
    }
    
    private func registerHomeUseCase() {
        diContainer.register(HomeUseCaseProtocol.self) { resolver in
            HomeUseCase(repository: resolver.resolve(HomeRepositoryProtocol.self)!)
        }
    }
    
    
    // MARK: - Repositories  등록
    private func registerRepositories() {
        registerAuthRepositories()
    }
    
    private func registerAuthRepositories() {
        diContainer.register(AuthRepositoryProtocol.self) { _ in
            AuthRepository()
        }
    }
    
    private func registerHomeRepositories() {
        diContainer.register(HomeRepositoryProtocol.self) { _ in
            HomeRepository()
        }
    }
    

}

