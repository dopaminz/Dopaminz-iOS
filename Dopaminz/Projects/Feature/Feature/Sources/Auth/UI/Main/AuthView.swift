//
//  AuthView.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import KeychainAccess

public struct AuthView: View {
    @Bindable var store: StoreOf<AuthFeature>
    var backAction: () -> Void = { }
    var goProfieAction: () -> Void = { }
    public init(
        store: StoreOf<AuthFeature>,
        backAction: @escaping () -> Void,
        goProfieAction: @escaping () -> Void
        
    ) {
        self.store = store
        self.backAction = backAction
        self.goProfieAction = goProfieAction
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                VStack {
                    Spacer()
                        .frame(height: 17)
                    
                    NavigationBackButton(buttonAction: {
                        let accesstoken = try? Keychain().get("AuthorizationToken")
                        print(accesstoken)
                        if accesstoken != "" {
                            backAction()
                        } else {
//                            backAction()
                        }
                        
                    })
                    
                    logoImage()
                   
                    loginTitle()
                    
                    loginButton()
                    
                    Spacer()
                    
                }
                
        } destination: { switchStore in
            switch switchStore.case {
            case let .login(loginStore):
                LoginView(store: loginStore, backAction: {
                    store.send(.removePath)
                }, goProfieAction: goProfieAction)
                .navigationBarBackButtonHidden()
            case let .signUP(signUPStore):
                SignUPView(store: signUPStore, backAction: {
                    store.send(.removePath)
                })
                .navigationBarBackButtonHidden()
                
            case let .signUPInfo(signUPInfoStore):
                SignUPInfoView(store: signUPInfoStore, backAction: {
                    store.send(.removePath)
                })
                .navigationBarBackButtonHidden()
            case let .profile(profileFeature):
                ProfileView(store: profileFeature)
                    .navigationBarBackButtonHidden()
                
            case let .web(webStore):
                WebViews(store: webStore)
                    .navigationBarBackButtonHidden()
                
            case let .selectCategory(selectCategoryFeature):
                SelectCategoryView(store: selectCategoryFeature, goProfieAction: goProfieAction)
                    .navigationBarBackButtonHidden()
                
            }
        }

        
    }
}

fileprivate extension AuthView {
    
    @ViewBuilder
    private func logoImage() -> some View {
        VStack {
            Spacer()
                .frame(height: 53.37)
            
            Image(asset: .logo)
                .resizable()
                .scaledToFit()
                .frame(width: 71, height: 68.8)
            
            Spacer()
                .frame(height: 19)
            
            Image(asset: .logoTItle)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 37)
        }
    }
    
    @ViewBuilder
    private func loginTitle() -> some View {
        VStack {
            Spacer()
                .frame(height: 56.37)
            
            Text(store.authTitle)
                .pretendardFont(family: .Bold, size: 20)
                .foregroundColor(Color.basicBlack)
            
            Spacer()
                .frame(height: 11)
            
            Text(store.authSubTitle)
                .pretendardFont(family: .Regular, size: 16)
                .foregroundColor(Color.gray)
            
            Text(store.authLastTitle)
                .pretendardFont(family: .Regular, size: 16)
                .foregroundColor(Color.gray)
            
        }
    }
    
    @ViewBuilder
    private func loginButton() -> some View {
        VStack {
            Spacer()
                .frame(height: 37)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray50)
                .frame(height: 58)
                .overlay {
                    Text("로그인 하러 가기")
                        .pretendardFont(family: .Bold, size: 24)
                        .foregroundColor(Color.basicBlack)
                }
                .onTapGesture {
                    store.send(.presentLogin)
                }

               
                
        }
        .padding(.horizontal, 20)
    }
}
 
