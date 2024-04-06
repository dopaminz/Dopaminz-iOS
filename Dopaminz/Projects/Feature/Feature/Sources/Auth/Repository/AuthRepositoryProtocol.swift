//
//  AuthRepositoryProtocol.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import Model

public protocol AuthRepositoryProtocol {
    func requsetLogin(
        userName: String,
        password: String,
        completion: @escaping () -> Void) async
    
    func requsetSignUP(
        userName: String,
        password: String,
        nickName: String,
        completion: @escaping () -> Void) async 
    
    func requsetProfile(
        completion: @escaping () -> Void) async
}
