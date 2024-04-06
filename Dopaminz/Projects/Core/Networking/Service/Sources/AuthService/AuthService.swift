//
//  AuthService.swift
//  Service
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import Moya
import API

public enum AuthService {
    case login(username: String, password: String)
    case signUP(username: String, password: String, nickname: String)
    case profile
}


extension AuthService: BaseTargetType {
    public var path: String {
        switch self {
        case .login:
            return DopaminzAuthAPI.loginURL
        case .signUP:
            return DopaminzAuthAPI.signUPURL
        case .profile:
            return DopaminzAuthAPI.profileURL
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .signUP:
            return .post
        case .profile:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .login(let username, let password):
            let parameters: [String: Any] = [
                "username": username,
                "password": password,
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .signUP(let username, let password, let nickname):
            let parameters: [String: Any] = [
                "username": username,
                "password": password,
                "nickname": nickname
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)

        case .profile:
            let parameters: [String: Any] = [
                :
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
