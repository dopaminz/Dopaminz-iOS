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
        .onReceive([cate].publisher.first()) { _ in
            do {
                let data = try JSONEncoder().encode(cate)
                var categoriesData = keychain[data: "selectedCategories"] ?? Data()
                categoriesData.append(data)
                keychain[data: "selectedCategories"] = categoriesData
                print(cate)
            } catch {
                print("Error encoding categories: \(error)")
            }
        }
        
    }
}

