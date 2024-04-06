//
//  PollModel.swift
//  Model
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation

// MARK: - Welcome
public struct PollModel: Codable {
    public let code: String?
    public let data: PollResponseModel?
    public let msg: String?
    
    public init(code: String?, data: PollResponseModel?, msg: String?) {
        self.code = code
        self.data = data
        self.msg = msg
    }
}

// MARK: - DataClass
public struct PollResponseModel: Codable {
    public let hasNext: Bool?
    public let contents: [Content]?
    
    public init(hasNext: Bool?, contents: [Content]?) {
        self.hasNext = hasNext
        self.contents = contents
    }
}

// MARK: - Content
public struct Content: Codable {
    public let pollID, memberID: Int?
    public let nickname, type, title, content: String?
    public let endDate, vote1, vote2, category: String?
    public let vote1Count, vote2Count: Int?
    public let isVoted: Bool?
    public let createdDate: String?

    enum CodingKeys: String, CodingKey {
        case pollID = "pollId"
        case memberID = "memberId"
        case nickname, type, title, content, endDate, vote1, vote2, category, vote1Count, vote2Count, isVoted, createdDate
    }
    
    public init(pollID: Int?, memberID: Int?, nickname: String?, type: String?, title: String?, content: String?, endDate: String?, vote1: String?, vote2: String?, category: String?, vote1Count: Int?, vote2Count: Int?, isVoted: Bool?, createdDate: String?) {
        self.pollID = pollID
        self.memberID = memberID
        self.nickname = nickname
        self.type = type
        self.title = title
        self.content = content
        self.endDate = endDate
        self.vote1 = vote1
        self.vote2 = vote2
        self.category = category
        self.vote1Count = vote1Count
        self.vote2Count = vote2Count
        self.isVoted = isVoted
        self.createdDate = createdDate
    }
}

extension Content: Identifiable, Equatable {
  public var id: Int { return pollID! }
}
