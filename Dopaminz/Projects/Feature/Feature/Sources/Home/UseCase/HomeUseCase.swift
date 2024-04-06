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
    
    public func requestVote(pollId: Int, voteNumber: Int) async {
        return await repository.requestVote(pollId: pollId, voteNumber: voteNumber)
    }
    
    public func createPoll(type: PollType, title: String, content: String, endDate: Date, vote1: String, vote2: String, category: PollCategory) async {
        return await repository.createPoll(type: type, title: title, content: content, endDate: endDate, vote1: vote1, vote2: vote2, category: category)
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
