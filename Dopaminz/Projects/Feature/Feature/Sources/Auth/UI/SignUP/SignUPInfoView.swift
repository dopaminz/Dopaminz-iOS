//
//  SignUPInfoView.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import Shareds
import ComposableArchitecture

public struct SignUPInfoView: View {
    @Bindable var store: StoreOf<SignUPInfoFeature>
    var backAction: () -> Void = {}
    
    public init(store: StoreOf<SignUPInfoFeature>, backAction: @escaping () -> Void) {
        self.store = store
        self.backAction = backAction
    }
    
    public var body: some View {
        VStack {
//            Spacer()
//                .frame(height: 16)
                        
          NavigationTitleButton(buttonAction: backAction, title: "회원가입")
            
            Spacer()
                .frame(height: 30)
            
            HStack {
                Text("회원정보를 입력해주세요")
                    .pretendardFont(family: .SemiBold, size: 20)
                    .foregroundColor(Color.basicBlack)
                
                Spacer()
                
            }
            .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 40)
            
            AccessoryTextField(text: $store.loginId, headerText: "아이디", placeholder: "아이디를 입력해주세요", validText: "사용가능한 아이디입니다") {
                CheckRegister.isValidateId(store.loginId)
            }
            .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 16)
            
            AccessoryTextField(text: $store.password, headerText: "비밀번호", placeholder: "영문, 숫자, 특수문자 조합 8자리 이상",validText: "사용가능한 비밀번호입니다") {
                CheckRegister.isValidatePassword(store.password)
            }
            .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 16)
            
            AccessoryTextField(text: $store.repassword, headerText: "비밀번호 확인", placeholder: "영문, 숫자, 특수문자 조합 8자리 이상", validText: "사용가능한 비밀번호입니다", inValidText: store.password != store.repassword ? "비밀번호가 일치하지 않습니다" : "") {
                CheckRegister.isValidatePassword(store.repassword)
            }
            .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 16)
            
            AccessoryTextField(text: $store.nickName, headerText: "닉네임", placeholder: "8자 이내 한글 혹은 영문", validText: "사용가능한 닉네임입니다") {
                CheckRegister.isValidNickName(store.nickName)
            }
            .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 16)
            
            signUPButton()
            
//            Spacer()
        }
        
        .onChange(of: store.loginId, perform: { newvalue in
            store.loginId = newvalue
        })
        .onChange(of: store.password, perform: { newvalue in
            store.password = newvalue
        })
        .onChange(of: store.repassword, perform: { newvalue in
            store.repassword = newvalue
        })
        
        .onChange(of: store.nickName, perform: { newvalue in
            store.nickName = newvalue
        })
    }
}

fileprivate extension SignUPInfoView {
    
    @ViewBuilder
    private func signUPButton() -> some View {
        VStack {
            Spacer()
                .frame(height: UIScreen.screenHeight*0.1)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray50)
                .frame(height: 52)
                .overlay {
                    Text("가입하기")
                        .pretendardFont(family: .SemiBold, size: 20)
                        .foregroundColor(Color.black)
                }
                .onTapGesture {
                    store.send(.signUP(
                        userName: store.loginId,
                        password: store.password,
                        nickName: store.nickName,
                        completion: {
                            
                        }))
                }
                .disabled(store.loginId == "" || store.password == "" || store.nickName == "")
            
            
        }
        .padding(.horizontal, 20)
    }
    
}
