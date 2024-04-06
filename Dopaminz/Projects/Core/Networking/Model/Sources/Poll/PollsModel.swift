//
//  PollsModel.swift
//  Model
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation

// MARK: - Welcome
public struct PollsModel: Codable {
    public let code: String?
    public let data: PollsResponseModel?
    public let msg: String?
    
    public init(code: String?, data: PollsResponseModel?, msg: String?) {
        self.code = code
        self.data = data
        self.msg = msg
    }
}

// MARK: - DataClass
public struct PollsResponseModel: Codable {
    public let pollID, memberID: Int?
    public let nickname, type, title, content: String?
    public let endDate, vote1, vote2: String?
    public let vote1Count, vote2Count: Int?
    public let category: String?
    public let isVoted: Bool?
    public let votedNumber: Int?
    public let createdDate: String?
    public let comments: [Comment]?
    

    public enum CodingKeys: String, CodingKey {
        case pollID = "pollId"
        case memberID = "memberId"
        case nickname, type, title, content, endDate, vote1, vote2, vote1Count, vote2Count, category, isVoted, votedNumber, createdDate, comments
    }
    
    
    public init(pollID: Int?, memberID: Int?, nickname: String?, type: String?, title: String?, content: String?, endDate: String?, vote1: String?, vote2: String?, vote1Count: Int?, vote2Count: Int?, category: String?, isVoted: Bool?, votedNumber: Int?, createdDate: String?, comments: [Comment]?) {
        self.pollID = pollID
        self.memberID = memberID
        self.nickname = nickname
        self.type = type
        self.title = title
        self.content = content
        self.endDate = endDate
        self.vote1 = vote1
        self.vote2 = vote2
        self.vote1Count = vote1Count
        self.vote2Count = vote2Count
        self.category = category
        self.isVoted = isVoted
        self.votedNumber = votedNumber
        self.createdDate = createdDate
        self.comments = comments
    }
}

// MARK: - Comment
public struct Comment: Codable, Equatable, Hashable {
    public let commentID, memberID: Int
    public let nickname, content, createdDate: String
    
    public enum CodingKeys: String, CodingKey {
        case commentID = "commentId"
        case memberID = "memberId"
        case nickname, content, createdDate
    }
    
    public init(commentID: Int, memberID: Int, nickname: String, content: String, createdDate: String) {
        self.commentID = commentID
        self.memberID = memberID
        self.nickname = nickname
        self.content = content
        self.createdDate = createdDate
    }
}

