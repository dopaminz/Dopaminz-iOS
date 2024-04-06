//
//  SignUPView.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

public struct SignUPView: View {
    @Bindable var store: StoreOf<SignUPFeature>
    var backAction: () -> Void =  { }
    
    public init(
        store: StoreOf<SignUPFeature>,
        backAction: @escaping () -> Void
    ) {
        self.store = store
        self.backAction = backAction
    }
    
    public var body: some View {
        VStack {
            Spacer()
                .frame(height: 16)
            
            
          NavigationTitleButton(buttonAction: backAction, title: "회원가입")
            
            signupTitle()
            
            agreeMentList()
            
            signUPButton()
            
            Spacer()
            
            
        }
    }
}


fileprivate extension SignUPView {
    @ViewBuilder
    private func signupTitle() -> some View {
        VStack {
            Spacer()
                .frame(height: 20)
            
            
            HStack {
                Text("회원가입을 위해")
                Spacer()
            }
            
            HStack {
                Text("약관에 동의해주세요")
                Spacer()
            }
        }
        .pretendardFont(family: .Medium, size: 22)
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func agreeMentList() -> some View {
        VStack {
            Spacer()
                .frame(height: 40)
            
            AgreeMentListView(
                checkAgreeButton: $store.isAllAgreed,
                showleft: false,
                title: "전체 약관에 동의합니다",
                agreeAllService: true,
                essential: .essential,
                webViewLoading: .constant(false),
                allServiceAction: {
                    store.send(.didTapAgreeAllPolicy)
                },
                serviceAction: {},
                gotoWebView: {}
            )
            
            Spacer()
                .frame(height: 15)
            
            Rectangle()
                .frame(height: 1)
                .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 20)
            
            AgreeMentListView(
                checkAgreeButton: $store.isTermsofServiceAgreed,
                showleft: true,
                title: "서비스 이용약관 동의",
                agreeAllService: false,
                essential: .essential,
                webViewLoading: .constant(false),
                allServiceAction: { } ,
                serviceAction: {
                    store.send(.didTapAgreeServicePolicy)
                },
                gotoWebView: {
//
                }
            )
            
            Spacer()
                .frame(height: 15)
            
            
            AgreeMentListView(
                checkAgreeButton: $store.isServicePolicyAgreed,
                showleft: true,
                title: "개인정보 수집 및 이용동의",
                agreeAllService: false,
                essential: .essential,
                webViewLoading: .constant(false),
                allServiceAction: { },
                serviceAction: {
                    store.send(.didTapAgreePrivacyPolicy)
                },
                gotoWebView: {
//                    self.store.send(.presentPolicyAgreedWeb)
                }
            )
            
        }
    }
    
    @ViewBuilder
    private func signUPButton() -> some View {
        VStack {
            Spacer()
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.5))
                .frame(height: 52)
                .disabled(!self.store.isConfirmButtonActivated)
                .overlay {
                    Text("계속하기")
                }
                .onTapGesture {
                    store.send(.presentSignUPInfo)
                }
            
        }
        .padding(.horizontal, 20)
    }
    
}
