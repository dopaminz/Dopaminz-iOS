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
            
            NavigationTitleButton(buttonAction: backAction, title: "로그인")
            
            Spacer()
                .frame(height: UIScreen.screenHeight*0.15)
            
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
    private func loginTextField() -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 62)
                .overlay {
                    TextField("아이디를 입력해주세요", text: $store.loginId)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .pretendardFont(family: .Bold, size: 22)
                        .foregroundColor(Color.basicBlack)
                        .padding(.horizontal, 10)
                    
                }
            
            Spacer()
                .frame(height: 7)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 62)
                .overlay {
                    SecureField("비밀번호를 입력해주세요", text: $store.password)
                        .textInputAutocapitalization(.never)
                        .pretendardFont(family: .Bold, size: 22)
                        .foregroundColor(Color.basicBlack)
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
                .fill(Color.gray.opacity(0.5))
                .frame(height: 58)
                .padding(.horizontal, 20)
                .overlay {
                    Text("로그인")
                        .pretendardFont(family: .Bold, size: 24)
                        .foregroundColor(Color.basicBlack)
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
            
                
                Text("|")
                
                Text("아이디·비밀번호 찾기")
                Spacer()
            }
            .pretendardFont(family: .Regular, size: 12)
            .foregroundColor(.init(hex: "364356"))
        }
    }
    
}
