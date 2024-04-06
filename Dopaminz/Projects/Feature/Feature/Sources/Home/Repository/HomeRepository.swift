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
    var pollMyModel: PollMyModel?
    var pollDetailModel: PollsModel?
    var pollDelteModel: PollDeleteModel?
    var voteModel: VoteModel?
    var createModel: CreatePoll?
    var pollCancellable: AnyCancellable?
    var pollMyCancellable: AnyCancellable?
    var pollsCancellable: AnyCancellable?
    var pollDeleteCancellable: AnyCancellable?
    var voteCancellable: AnyCancellable?
    var createPollCancellable: AnyCancellable?
    var commentCancellable: AnyCancellable?
    let provider = MoyaProvider<PollsAPIService>(plugins: [MoyaLoggingPlugin()])
  
    var isLoading = false
    
    var isLoadingPollDetail = false
    
    
    public func pollRepositoryModel(_ list: PollModel) {
        self.pollModel = list
    }
    
    public func pollDetailRepositoryModel(_ list: PollsModel) {
        self.pollDetailModel = list
    }
    
    public func pollDeleteRepositoryModel(_ list: PollDeleteModel) {
        self.pollDelteModel = list
    }
    
    public func pollCreateRepositoryMode(_ list: CreatePoll){
        self.createModel = list
    }

    public func pollMyRepositoryModel(_ list: PollMyModel) {
        self.pollMyModel = list
    }
    
    public func voteRepositoryModel(_ list: VoteModel) {
        self.voteModel = list
    }
    
    public func requestPollDetail(id: Int) async {
        if let cancellable = pollsCancellable {
            cancellable.cancel()
        }
        
        isLoadingPollDetail = true
        
        pollsCancellable = provider.requestWithProgressPublisher(.requestPoll(id: id))
            .compactMap {$0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: PollsModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    self?.isLoadingPollDetail = false
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
        await requestPoll(page: 0, categories: categories, hot: hot, createdDate: createdDate)
    }
    
    public func requestPoll(
        page: Int,
        categories: [PollCategory],
        hot: Bool,
        createdDate: Model.SortType
    ) async {
        isLoading = true
        pollModel = nil
        
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
                case "400":
                    self?.pollRepositoryModel(model)
                default:
                    break
                }
            })
    }
    
    public func requestpollMy() async {
        if let cancellable = pollMyCancellable {
            cancellable.cancel()
        }
        pollMyCancellable = provider.requestWithProgressPublisher(.pollsMy)
            .compactMap {$0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: PollMyModel.self, decoder: JSONDecoder())
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
                    self?.pollMyRepositoryModel(model)
                    Log.network("히스토리 상세 조회", model)
                case "400":
                    self?.pollMyRepositoryModel(model)
                    Log.network("히스토리 상세 조회 에러", model)
                default:
                    break
                }
            })
    }
    
    public func requestVote(pollId: Int, voteNumber: Int) async {
        if let cancellable = voteCancellable {
            cancellable.cancel()
        }
        
        voteCancellable = provider.requestWithProgressPublisher(.vote(pollId: pollId, voteNumber: voteNumber))
            .compactMap{$0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: VoteModel.self, decoder: JSONDecoder())
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
                    self?.voteRepositoryModel(model)
                    Log.network("투표 성공", model)
                case "400":
                    self?.voteRepositoryModel(model)
                    Log.network("투표 실패", model)
                    
                default:
                    break
                }
            })
    }
    
    public func createPoll(type: Model.PollType, title: String, content: String, endDate: Date, vote1: String, vote2: String, category: Model.PollCategory) async {
        if let cancellable = createPollCancellable {
            cancellable.cancel()
        }
        
        createPollCancellable = provider.requestWithProgressPublisher(.createPoll(type: type, title: title, content: content, endDate: endDate, vote1: vote1, vote2: vote2, category: category))
            .compactMap{$0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: CreatePoll.self, decoder: JSONDecoder())
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
                    self?.pollCreateRepositoryMode(model)
                    Log.network("글 등록 성공", model)
                case "400":
                    self?.pollCreateRepositoryMode(model)
                    Log.network("글 등록 실패", model)
                    
                default:
                    break
                }
            })
    }
    
    public func createComment(pollId: Int, content: String) async {
        if let cancellable = commentCancellable {
            cancellable.cancel()
        }
        
        commentCancellable = provider.requestWithProgressPublisher(.postComment(pollId: pollId, content: content))
            .compactMap{ $0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: CreatePoll.self, decoder: JSONDecoder())
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
                    self?.pollCreateRepositoryMode(model)
                    Log.network("댓글 등록 완료", model)
                case "400":
                    self?.pollCreateRepositoryMode(model)
                    Log.network("댓글 등록 실패", model)
                    
                default:
                    break
                }
            })
    }
}
