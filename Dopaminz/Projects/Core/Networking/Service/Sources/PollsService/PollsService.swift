//
//  PollsService.swift
//  Service
//
//  Created by 이승기 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import Moya
import API
import Model

public enum PollsAPIService {
  // 퀵폴 & 사연 목록 조회 (메인)
  case requestPolls(
    page: Int,
    categories: [PollCategory],
    hot: Bool,
    createdDate: SortType)
  
  // 퀵폴 & 사연 상세 조회 (디테일)
  case requestPoll(id: Int)
  
  // 퀵폴 & 사연 작성
  case createPoll(
    type: PollType,
    title: String,
    content: String,
    endDate: Date,
    vote1: String,
    vote2: String,
    category: PollCategory)
  
  // 퀵폴 & 사연 삭제 (디테일)
  case deletePoll(id: Int)
  
  // 최초 투표   (디테일, 메인)
  case vote(pollId: Int, voteNumber: Int)
  
  // 투표 수정   (디테일, 메인)
  case revote(voteId: Int, voteNumber: Int)
  
  // 댓글 작성 (디테일)
  case postComment(pollId: Int, content: String)
  
  // 댓글 삭제 (디테일)
  case deleteComment(commentId: Int)
}

extension PollsAPIService: BaseTargetType {
  public var path: String {
    switch self {
    case .requestPolls(let page, let categories, let hot, let createdDate):
      return PollsAPI.requestPolls
      
    case .requestPoll(let id):
      return "\(PollsAPI.requestPoll)/\(id)"
      
    case .createPoll:
      return PollsAPI.createPoll
      
    case .deletePoll(let id):
      return "\(PollsAPI.deletePoll)/\(id)"
      
    case .vote:
      return PollsAPI.vote
      
    case .revote(let voteId, _):
      return "\(PollsAPI.revote)/\(voteId)"
      
    case .postComment(let pollId, let content):
      return PollsAPI.postComment
      
    case .deleteComment(let commentId):
      return "\(PollsAPI.deleteComment)/\(commentId)"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .requestPolls:
      return .get
    
    case .requestPoll:
      return .get
    
    case .createPoll:
      return .post
      
    case .deletePoll:
      return .delete
      
    case .vote:
      return .post
      
    case .revote:
      return .put
      
    case .postComment:
      return .post
      
    case .deleteComment:
      return .delete
    }
  }
  
  public var task: Moya.Task {
    switch self {
    case .requestPolls(let page, let categories, let hot, let createdDate):
      let categoryStrings = categories.map { $0.rawValue }
      let parameters: [String: Any] = [
        "hot": hot,
        "createdDate": createdDate.rawValue,
        "categories": categoryStrings.joined(separator: ","),
        "page": page
      ]
      return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
      
    case .requestPoll:
      return .requestPlain
      
    case .createPoll(let type, let title, let content, let endDate, let vote1, let vote2, let category):
      let parameters: [String: Any] = [
        "type": type.rawValue,
        "title": title,
        "content": content,
        "endDate": endDate,
        "vote1": vote1,
        "vote2": vote2,
        "category": category.rawValue
      ]
      return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
      
    case .deletePoll:
      return .requestPlain
      
    case .vote(let pollId, let voteNumber):
      let parameters: [String: Any] = [
        "pollId": pollId,
        "voteNumber": voteNumber
      ]
      return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
      
    case .revote(_, let voteNumber):
      let parameters: [String: Any] = [
        "voteNumber": voteNumber
      ]
      return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
      
    case .postComment(let pollId, let content):
      let parameters: [String: Any] = [
        "pollId": pollId,
        "content": content
      ]
      return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
      
    case .deleteComment(let commentId):
      return .requestPlain
    }
  }
}
