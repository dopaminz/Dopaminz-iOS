//
//  ProfileView.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import KeychainAccess

public struct ProfileView: View {
    @Bindable var store: StoreOf<ProfileFeature>
    var repostitory = AuthRepository()
    @State var nickName: String = ""
    public init(
        store: StoreOf<ProfileFeature>
    ) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack {
                Spacer()
                    .frame(height: 15)
                
                Text("마이페이지")
                    .pretendardFont(family: .SemiBold, size: 18)
                    .foregroundColor(Color.basicBlack)
                Spacer()
                    .frame(height: 44)
                
                HStack {
                    Text(nickName)
                        .pretendardFont(family: .Bold, size: 18)
                        .foregroundColor(Color.basicBlack)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 40)

                HStack {
                    Text("서비스 이용약관")
                        .pretendardFont(family: .Medium, size: 18)
                        .foregroundColor(Color.basicBlack)
                        .onTapGesture {
                            store.send(.presentPolicyAgreedWeb)
                        }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 32)
                
                HStack {
                    Text("개인정보 처리방침")
                        .pretendardFont(family: .Medium, size: 18)
                        .foregroundColor(Color.basicBlack)
                        .onTapGesture {
                            store.send(.presentWebTermsofService)
                        }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 40)
                
                HStack {
                    Text("로그아웃")
                        .pretendardFont(family: .Medium, size: 18)
                        .foregroundColor(Color.basicBlack)
                        .onTapGesture {
                            store.send(.logout)
                        }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            
            
            .onAppear {
                if store.acessToken == "" {
                    store.send(.presnetAuthFullScreen)
                } else {
                }
                let nickName = (try? Keychain().get("nickname")) ?? ""
                self.nickName = nickName
                print(nickName, self.nickName)
                
            }
            .task {
                await repostitory.requsetProfile(completion: {})
            }
            
            .onChange(of: repostitory.profileModel?.data?.nickname ?? "") { newValue in
                self.nickName = newValue
            }
        } destination: { switchStore in
            switch switchStore.case {
            case let .web(webStore):
                WebViews(store: webStore)
                    .navigationBarBackButtonHidden()
            }
        }

        
        
        
        .fullScreenCover(item: $store.scope(state: \.auth, action: \.auth)) { authStore in
            AuthView(store: authStore, backAction: {
                store.send(.closeBottomSheet)
            }) {
                store.send(.closeBottomSheet)
            }
        }
    }
}


