//
//  AuthModel.swift
//  Model
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation

// MARK: - Welcome
public struct AuthModel: Codable {
    public let code: String?
    public let data: AuthModelResponse?
    public let msg: String?
    
    public init(
        code: String?,
        data: AuthModelResponse?,
        msg: String?
    ) {
        self.code = code
        self.data = data
        self.msg = msg
    }
}

// MARK: - DataClass
public struct AuthModelResponse: Codable {
    public let accessToken: String?
    
    public init(
        accessToken: String?
    ) {
        self.accessToken = accessToken
    }
}
