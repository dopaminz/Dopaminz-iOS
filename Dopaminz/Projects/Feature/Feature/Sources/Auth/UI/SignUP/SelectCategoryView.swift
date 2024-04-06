//
//  SelectCategoryView.swift
//  Feature
//
//  Created by 서원지 on 4/7/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import Model
import KeychainAccess

public struct SelectCategoryView: View {
    @Bindable var store: StoreOf<SelectCategoryFeature>
    @State var cate: [PollCategory] = []
    var goProfieAction: () -> Void = { }
    let keychain = Keychain(service: "com.example.app")

    public init(store: StoreOf<SelectCategoryFeature>, goProfieAction: @escaping () -> Void) {
        self.store = store
        self.goProfieAction = goProfieAction
    }
    
    
    
    public var body: some View {
        VStack {
            Spacer()
                .frame(height: 17)
            
            HStack {
                Spacer()
                
                Text("건너띄기")
                    .pretendardFont(family: .Medium, size: 15)
                    .foregroundColor(Color.gray500)
                    .onTapGesture {
                        goProfieAction()
                    }
                
            }
            .padding(.horizontal, 20)
            
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                
                Text("홈에서 보고싶음")
                
                Spacer()
            }
            .pretendardFont(family: .Medium, size: 22)
            .foregroundColor(Color.basicBlack)
            .padding(.horizontal,20)
            
            HStack {
                
                Text("카테고리를 선택해주세요")
                
                Spacer()
            }
            .pretendardFont(family: .Medium, size: 22)
            .foregroundColor(Color.basicBlack)
            .padding(.horizontal,20)
            
            Spacer()
                .frame(height: 34)
            
            CategoryPicker(categories: $cate)
                .padding(.horizontal, 20)
                
            
            Spacer()
        }
        
        Spacer()
            .frame(height: UIScreen.screenHeight*0.3)
        
        RoundedRectangle(cornerRadius: 12)
            .fill(self.cate.isEmpty ? Color.gray50 : Color.blue500)
            .frame(height: 52)
            .overlay {
                Text("다 선택했어요")
                    .pretendardFont(family: .SemiBold, size: 20)
                    .foregroundColor(self.cate.isEmpty ? Color.black : Color.basicWhite)
            }
            .padding(.horizontal, 20)
            .onTapGesture {
                goProfieAction()
            }
        
    }
}

