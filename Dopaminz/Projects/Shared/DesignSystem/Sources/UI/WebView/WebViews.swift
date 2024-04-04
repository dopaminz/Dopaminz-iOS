//
//  WebViews.swift
//  DesignSystem
//
//  Created by 서원지 on 4/4/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import SwiftUI

import SDWebImageSwiftUI
import ComposableArchitecture

public struct WebViews: View {
    @Bindable var store: StoreOf<WebFeature>
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    public init(
        store: StoreOf<WebFeature>
        ) {
            self.store = store
        }
    
    public var body: some View {
        VStack {
            if store.loading {
                
                Spacer()
                
                AnimatedImage(name: "loading.gif", isAnimating: .constant(true))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Spacer()
                
            } else {
                WebView(urlToLoad: store.url)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                customBackButton()
            }
        }
        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                loading = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // Replace 2 with desired delay
//                    loading = false
//                }
//            }
            
            store.send(.startLoading)
        }
        
    }
    
    //MARK: - 뒤로 가기 버튼
    @ViewBuilder
    private func customBackButton() -> some View {
        Button {
            self.store.send(.didTapBackButton)
        } label: {
            Image(systemName: "chevron.left")
                .frame(width: 30, height: 30)
                .foregroundColor(.black)
        }
        
    }
}


