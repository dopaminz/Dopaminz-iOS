//
//  CreatePoll.swift
//  Model
//
//  Created by 서원지 on 4/7/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
// MARK: - Welcome
public struct CreatePoll: Codable {
    public let code, data, msg: String?
    
    public init(code: String?, data: String?, msg: String?) {
        self.code = code
        self.data = data
        self.msg = msg
    }
}

