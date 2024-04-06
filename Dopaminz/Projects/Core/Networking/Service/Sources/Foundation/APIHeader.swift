//
//  APIHeader.swift
//  Service
//
//  Created by 서원지 on 4/4/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import API
import KeychainAccess

struct APIConstants{
    
    static let contentType = "Content-Type"
    static let authorization = "Authorization"
    static let appPackageName = "App-Package-Name"
    static let apikey =  "apikey"
    static let cookie = "Cookie"
    static let authorizationToken = (try? Keychain().get("AuthorizationToken")) ?? ""
}

extension APIConstants {
    static var baseHeader: Dictionary<String, String> {
        [
          authorization : authorizationToken,
          contentType: APIHeaderManger.shared.contentType
        ]
    }
    static var appleLoginHeader: Dictionary<String, String> {
        [
          contentType : APIHeaderManger.shared.contentAppleType
        ]
    }
}


