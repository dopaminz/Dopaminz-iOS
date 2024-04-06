//
//  AuthRepository.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Moya
import CombineMoya
import Model
import KeychainAccess
import Service
import API

@Observable public class AuthRepository: AuthRepositoryProtocol {
    

    
    var authModel: AuthModel?
    var profileModel: ProfileModel?
    var signCancellable: AnyCancellable?
    var loginCancellable: AnyCancellable?
    var profileCancellable: AnyCancellable?
    let provider = MoyaProvider<AuthService>(plugins: [MoyaLoggingPlugin()])
    
    
    public init() {}
    
    
    func authRepositoryModel(_ list: AuthModel) {
        self.authModel = list
    }
    
    func profileRepositoryModel(_ list: ProfileModel) {
        self.profileModel = list
    }
    
    
    public func requsetLogin(
        userName: String,
        password: String,
        completion: @escaping () -> Void
    ) async {
        if let cancellable = loginCancellable {
            cancellable.cancel()
        }
        
        loginCancellable = provider.requestWithProgressPublisher(.login(username: userName, password: password))
            .compactMap{ $0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: AuthModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    Log.error("네트워크 에러", error.localizedDescription)
                    
                }
            }, receiveValue: { [weak self] model in
                self?.authRepositoryModel(model)
                switch model.code {
                case "200":
                    self?.authRepositoryModel(model)
                    Log.network("로그인 성공", model)
                    try? Keychain().set(model.data?.accessToken ?? "", key: "AuthorizationToken")
                    completion()
                case "400":
                    self?.authRepositoryModel(model)
                    Log.network("로그인 싪패", model)
                case "401":
                    self?.authRepositoryModel(model)
                    Log.network("비밀번호 오류", model)
                default:
                    break
                }
            })
    }
    
    public func requsetSignUP(
        userName: String,
        password: String,
        nickName: String,
        completion: @escaping () -> Void
    ) async {
        if let cancellable = signCancellable {
            cancellable.cancel()
        }
        
        signCancellable = provider.requestWithProgressPublisher(.signUP(username: userName, password: password, nickname: nickName))
            .compactMap{ $0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: AuthModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    Log.error("네트워크 에러", error.localizedDescription)
                    
                }
            }, receiveValue: { [weak self] model in
                switch model.code {
                case "200":
                    self?.authRepositoryModel(model)
                    Log.network("회원가입 성공", model)
                    try? Keychain().set(model.data?.accessToken ?? "", key: "AuthorizationToken")
                    completion()
                case "400":
                    Log.network("회원가입 실패", model)
                    self?.authRepositoryModel(model)
                case "401":
                    Log.network("회원가입 에러", model)
                    self?.authRepositoryModel(model)
                default:
                    break
                }
            })
        
    }
    
    public func requsetProfile(completion: @escaping () -> Void) async {
        if let cancellable = profileCancellable {
            cancellable.cancel()
        }
        
        profileCancellable = provider.requestWithProgressPublisher(.profile)
            .compactMap{ $0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: ProfileModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    Log.error("네트워크 에러", error.localizedDescription)
                    
                }
            }, receiveValue: { [weak self] model in
                switch model.code {
                case "200":
                    self?.profileRepositoryModel(model)
                    Log.network("포로필 조회 성공", model)
                    completion()
                case "400":
                    self?.profileRepositoryModel(model)
                    Log.network("포로필 조회 에러", model)
                case "401":
                    self?.profileRepositoryModel(model)
                    Log.network("포로필 조회 에러", model)
                default:
                    break
                }
            })
    }
}
