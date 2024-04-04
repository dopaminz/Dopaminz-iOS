//
//  AppleLoginTarget.swift
//  Service
//
//  Created by 서원지 on 4/4/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import Moya
import API

public protocol AppleLoginTarget: TargetType {}


extension AppleLoginTarget {
    public var baseURL: URL {
        return URL(string: DopaminzAPI.appleLoginBaseURL)!
    }
    
    public var headers: [String : String]? {
        return APIConstants.appleLoginHeader
    }
    
}

