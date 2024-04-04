//
//  APIHeaderManger.swift
//  API
//
//  Created by 서원지 on 4/4/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation

public class APIHeaderManger {
    public static let shared = APIHeaderManger()
    
    public init() {}
    
    public let appPackageName: String = "-"
    public let contentType: String = "application/json"
    public let contentAppleType: String = "application/x-www-form-urlencoded"
}
