//
//  PollDelete.swift
//  Model
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
// MARK: - Welcome
public struct PollDeleteModel: Codable {
    public let code, data, msg: String?
    
    public init(code: String?, data: String?, msg: String?) {
        self.code = code
        self.data = data
        self.msg = msg
    }
}
