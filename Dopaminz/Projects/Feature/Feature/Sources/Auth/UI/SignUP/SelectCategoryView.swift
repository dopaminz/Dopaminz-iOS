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

public struct SelectCategoryView: View {
    @Bindable var store: StoreOf<SelectCategoryFeature>
    var goProfieAction: () -> Void = { }

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
                
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        
    }
}

