//
//  PollMyModel.swift
//  Model
//
//  Created by 서원지 on 4/7/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
// MARK: - Welcome
public struct PollMyModel: Codable {
    public let code: String?
    public let data: [PollMyResponseModel]?
    public let msg: String?
    
    public init(code: String?, data: [PollMyResponseModel]?, msg: String?) {
        self.code = code
        self.data = data
        self.msg = msg
    }
}

// MARK: - Datum
public struct PollMyResponseModel: Codable, Identifiable {
    public let id = UUID().uuidString
    public let pollID: Int?
    public let type: String?
    public let title, content, endDate, vote1: String?
    public let vote2: String?
    public let vote1Count, vote2Count: Int?
    public let category, createdDate: String?

    
    public enum CodingKeys: String, CodingKey {
        case pollID = "pollId"
        case type, title, content, endDate, vote1, vote2, vote1Count, vote2Count, category, createdDate
    }
    
    public init(pollID: Int?, type: String?, title: String?, content: String?, endDate: String?, vote1: String?, vote2: String?, vote1Count: Int?, vote2Count: Int?, category: String?, createdDate: String?) {
        self.pollID = pollID
        self.type = type
        self.title = title
        self.content = content
        self.endDate = endDate
        self.vote1 = vote1
        self.vote2 = vote2
        self.vote1Count = vote1Count
        self.vote2Count = vote2Count
        self.category = category
        self.createdDate = createdDate
    }
}
