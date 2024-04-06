//
//  LoginView.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

public struct LoginView: View {
    @Bindable var store: StoreOf<LoginFeature>
    var backAction: () -> Void = { }
    var goProfieAction: () -> Void = { }
    
    public init(
        store: StoreOf<LoginFeature>,
        backAction: @escaping () -> Void,
        goProfieAction: @escaping () -> Void
        
    ) {
        self.store = store
        self.backAction = backAction
        self.goProfieAction = goProfieAction
    }
    
    public var body: some View {
        VStack {
            Spacer()
                .frame(height: 17)
            
            NavigationTitleButton(title: "로그인") {
              backAction()
            }
            
            logoImage()
            
            loginTextField()
            
            loginButton()
            
            signUPButton()
            
            Spacer()
        }
        
        .onChange(of: store.loginId) { newValue in
            store.loginId = newValue
        }
        
        .onChange(of: store.password) { newValue in
            store.password = newValue
        }
        
    }
}


fileprivate extension LoginView {
    
    
    @ViewBuilder
    private func logoImage() -> some View {
        VStack {
            Spacer()
                .frame(height: 45.56)
            
            Image(asset: .logoTitle2)
                .resizable()
                .scaledToFit()
                .frame(width: 163, height: 40)
        }
    }
    
    
    @ViewBuilder
    private func loginTextField() -> some View {
        VStack {
            Spacer()
                .frame(height: 56.17)
            
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray200, style: .init(lineWidth: 1))
                .frame(height: 62)
                .overlay {
                    TextField("아이디", text: $store.loginId)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .pretendardFont(family: .Medium, size: 16)
                        .foregroundColor(Color.gray400)
                        .padding(.horizontal, 10)
                    
                }
            
            Spacer()
                .frame(height: 7)
            
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray200, style: .init(lineWidth: 1))
                .frame(height: 62)
                .overlay {
                    SecureField("비밀번호", text: $store.password)
                        .textInputAutocapitalization(.never)
                        .pretendardFont(family: .Medium, size: 16)
                        .foregroundColor(Color.gray400)
                        .padding(.horizontal, 10)
                    
                }
            
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func loginButton() -> some View {
        VStack {
            Spacer()
                .frame(height: 35)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.blue500)
                .frame(height: 58)
                .padding(.horizontal, 20)
                .overlay {
                    Text("로그인")
                        .pretendardFont(family: .Bold, size: 24)
                        .foregroundColor(Color.white)
                }
                .onTapGesture {
                    store.send(.login(userName: store.loginId, password: store.password, completion: {
                        goProfieAction()
                    }))
                }
        }
    }
    
    @ViewBuilder
    private func signUPButton() -> some View {
        VStack {
            Spacer()
                .frame(height: 22)
            
            HStack {
                Spacer()
                
                Text("회원가입")
                    .onTapGesture {
                        store.send(.presntSignUP)
                    }
            
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 6, height: 11)
                
                Text("아이디·비밀번호 찾기")
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 6, height: 11)
                
                Spacer()
            }
            .pretendardFont(family: .Regular, size: 12)
            .foregroundColor(Color.gray500)
        }
    }
    
}
