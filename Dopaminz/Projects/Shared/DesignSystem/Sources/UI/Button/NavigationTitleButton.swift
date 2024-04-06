//
//  NavigationTitleButton.swift
//  DesignSystem
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import SwiftUI

public struct NavigationTitleButton: View {
    var buttonAction: () -> Void = { }
    var title: String
    
    public init(
      title: String,
      buttonAction: @escaping () -> Void
    ) {
        self.buttonAction = buttonAction
        self.title = title
    }
    
    public var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 18)
                .foregroundColor(.basicGray8)
                .onTapGesture {
                    buttonAction()
                }
            
            Spacer()
            
            Text(title)
                .pretendardFont(family: .SemiBold, size: 18)
                .foregroundColor(Color.basicBlack)
            
            Spacer()
            
        }
        .padding(.horizontal, 20)
    }
}
