//
//  NavigationTitleBackButton.swift
//  DesignSystem
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import SwiftUI

public struct NavigationTitleBackButton: View {
    
    // MARK: - Properties
    
    var buttonAction: () -> Void = { }
    var image: ImageAsset
    var title: String
    
    // MARK: - Initializers
    
    public init(
        buttonAction: @escaping () -> Void,
        image: ImageAsset,
        title: String
    ) {
        self.buttonAction = buttonAction
        self.image = image
        self.title = title
    }
    
    public var body: some View {
        ZStack {
            HStack {
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
                }
                
            }
            
            Text(title)
                .font(.pretendardFontFamily(family: .SemiBold, size: 18))
                .foregroundStyle(Color.black)
        }
        .padding(.horizontal, 20)
    }
}

