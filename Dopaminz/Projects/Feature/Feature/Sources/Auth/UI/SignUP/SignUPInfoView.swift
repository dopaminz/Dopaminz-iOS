//
//  SignUPInfoView.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
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
            Spacer()
                .frame(height: 16)
                        
          NavigationTitleButton(buttonAction: backAction, title: "회원가입")
            
            
            signUPButton()
            Spacer()
        }
        
        .onChange(of: store.loginId, perform: { newvalue in
            store.loginId = newvalue
        })
        .onChange(of: store.password, perform: { newvalue in
            store.password = newvalue
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
                .frame(height: UIScreen.screenHeight*0.4)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.8))
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
