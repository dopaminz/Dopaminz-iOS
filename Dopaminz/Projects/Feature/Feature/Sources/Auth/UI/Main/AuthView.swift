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

public struct AuthView: View {
    @Bindable var store: StoreOf<AuthFeature>
    var backAction: () -> Void = { }
    
    public init(
        store: StoreOf<AuthFeature>,
        backAction: @escaping () -> Void
        
    ) {
        self.store = store
        self.backAction = backAction
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ZStack {
                Color.basicWhite
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                        .frame(height: 17)
                    
                    NavigationBackButton(buttonAction: backAction)
                    
                    logoImage()
                   
                    loginButton()
                    
                    
                    Spacer()
                    
                }
                
            }
        } destination: { switchStore in
            switch switchStore.case {
            case let .login(loginStore):
                LoginView(store: loginStore, backAction: {
                    store.send(.removePath)
                })
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
                .frame(height: UIScreen.screenHeight*0.2)
            
            Circle()
                .stroke(Color.basicBlack, style: .init(lineWidth: 1))
                .frame(width: 126, height: 126)
                .overlay {
                    
                }
        }
    }
    
    @ViewBuilder
    private func loginButton() -> some View {
        VStack {
            Spacer()
                .frame(height: UIScreen.screenHeight*0.4)
            
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.basicBlack, style: .init(lineWidth: 2))
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
 
