//
//  HomeRepository.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import Combine
import CombineMoya
import Moya
import Model
import Service

@Observable public class HomeRepository: HomeRepositoryProtocol {
    
    public init() {}
    
    var pollModel: PollModel?
    var pollDetailModel: PollsModel?
    var pollDelteModel: PollDeleteModel?
    var pollCancellable: AnyCancellable?
    var pollsCancellable: AnyCancellable?
    var pollDeleteCancellable: AnyCancellable?
    let provider = MoyaProvider<PollsAPIService>(plugins: [MoyaLoggingPlugin()])
  
    var isLoading = false
    
    private var page: Int = 0
    var polls: [Content] = []
    
    
    public func pollRepositoryModel(_ list: PollModel) {
        self.pollModel = list
        polls.append(contentsOf: list.data?.contents ?? [])
    }
    
    public func pollDetailRepositoryModel(_ list: PollsModel) {
        self.pollDetailModel = list
    }
    
    public func pollDeleteRepositoryModel(_ list: PollDeleteModel) {
        self.pollDelteModel = list
    }

    
    public func requestPollDetail(id: Int) async {
        if let cancellable = pollsCancellable {
            cancellable.cancel()
        }
        pollsCancellable = provider.requestWithProgressPublisher(.deletePoll(id: id))
            .compactMap {$0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: PollsModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    Log.network("네트워크 에러", error.localizedDescription)
                    
                }
            }, receiveValue: { [weak self] model in
                switch model.code {
                case "200":
                    self?.pollDetailRepositoryModel(model)
                    Log.network("목록 상세 조회", model)
                case "400":
                    self?.pollDetailRepositoryModel(model)
                    Log.network("목록 상세 조회 에러", model)
                default:
                    break
                }
            })
        
    }
    
    public func requestPollDelete(id: Int) async {
        if let cancellable = pollDeleteCancellable {
            cancellable.cancel()
        }
        pollDeleteCancellable = provider.requestWithProgressPublisher(.deletePoll(id: id))
            .compactMap {$0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: PollDeleteModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    Log.network("네트워크 에러", error.localizedDescription)
                    
                }
            }, receiveValue: { [weak self] model in
                switch model.code {
                case "200":
                    self?.pollDeleteRepositoryModel(model)
                    Log.network("목록 삭제", model)
                case "400":
                    self?.pollDeleteRepositoryModel(model)
                    Log.network("목록 삭제 에러", model)
                default:
                    break
                }
            })
    }
    
    public func requestPoll(
        categories: [PollCategory],
        hot: Bool,
        createdDate: SortType
    ) async {
        await requestPoll(page: self.page, categories: categories, hot: hot, createdDate: createdDate)
    }
    
    public func requestPoll(
        page: Int,
        categories: [PollCategory],
        hot: Bool,
        createdDate: Model.SortType
    ) async {
        isLoading = true
        
        if let cancellable = pollCancellable { cancellable.cancel() }
        pollCancellable =  provider.requestWithProgressPublisher(.requestPolls(page: page, categories: categories, hot: hot, createdDate: createdDate))
            .compactMap {$0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: PollModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                self?.isLoading = false
                
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    Log.error("네트워크 에러", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                switch model.code {
                case "200":
                    self?.pollRepositoryModel(model)
                    Log.network("목록 조회", model)
                    self?.page += 1
                case "400":
                    self?.pollRepositoryModel(model)
                default:
                    break
                }
            })
    }
}
