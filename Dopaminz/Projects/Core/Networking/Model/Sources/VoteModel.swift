//
//  VoteModel.swift
//  Model
//
//  Created by 서원지 on 4/7/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation

// MARK: - Welcome
public struct VoteModel: Codable {
    public let code: String?
    public let data: VoteResponseModel?
    public let msg: String?
    
    public init(code: String?, data: VoteResponseModel?, msg: String?) {
        self.code = code
        self.data = data
        self.msg = msg
    }
}

// MARK: - DataClass
public struct VoteResponseModel: Codable {
    public let vote1Count, vote2Count: Int?
    
    public init(vote1Count: Int?, vote2Count: Int?) {
        self.vote1Count = vote1Count
        self.vote2Count = vote2Count
    }
}

