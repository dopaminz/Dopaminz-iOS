//
//  BaseTargetType.swift
//  Service
//
//  Created by 서원지 on 4/4/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import Moya
import API

public protocol BaseTargetType: TargetType {}


extension BaseTargetType {
    public var baseURL: URL {
        return URL(string: DopaminzAPI.baseURL)!
    }
    
    public var headers: [String : String]? {
        return APIConstants.baseHeader
    }
    
}

