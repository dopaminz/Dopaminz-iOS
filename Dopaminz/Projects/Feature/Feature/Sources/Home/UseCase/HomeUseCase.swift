//
//  HomeUseCase.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import Model
import ComposableArchitecture
import DiContainer

public struct HomeUseCase: HomeUseCaseProtocol  {
    
  
    private let repository: HomeRepositoryProtocol
    
    public init(
        repository: HomeRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    public func requestPoll(page: Int, categories: [PollCategory], hot: Bool, createdDate: SortType) async {
        return await repository.requestPoll(page: page, categories: categories, hot: hot, createdDate: createdDate)
    }
    
    public func requestPoll() async {
       
    }
    
    public func requestPollDetail(id: Int) async {
        return await repository.requestPollDetail(id: id)
    }
    
    public func requestPollDelete(id: Int) async {
        return await repository.requestPollDetail(id: id)
    }
   
    public func requestpollMy() async {
        return await repository.requestpollMy()
    }
}

extension HomeUseCase: DependencyKey {
    public static let liveValue: HomeUseCase = {
           let homeRepository = DIContainer.container.resolve(HomeRepositoryProtocol.self) ?? DefaultHomeRepository()
           return HomeUseCase(repository: homeRepository)
       }()
}

public extension DependencyValues {
    var homeUseCase: HomeUseCaseProtocol {
        get { self[HomeUseCase.self] }
        set { self[HomeUseCase.self] = newValue as! HomeUseCase}
    }
}
