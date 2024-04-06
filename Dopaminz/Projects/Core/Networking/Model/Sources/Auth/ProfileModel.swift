//
//  ProfileModel.swift
//  Model
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation

// MARK: - Welcome
public struct ProfileModel: Codable {
    public let code: String?
    public let data: ProfileResponseModel?
    public let msg: String?
    
    public init(code: String?, data: ProfileResponseModel?, msg: String?) {
        self.code = code
        self.data = data
        self.msg = msg
    }
}

// MARK: - DataClass
public struct ProfileResponseModel: Codable {
    public let id: Int?
    public let nickname: String?
    
    public init(id: Int?, nickname: String?) {
        self.id = id
        self.nickname = nickname
    }
}

