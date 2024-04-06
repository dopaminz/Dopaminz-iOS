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
    var buttonAction: () -> Void = { }
    var leftAction: () -> Void = { }
    var image: ImageAsset
    var showBackButton: Bool
    
    public init(
        buttonAction: @escaping () -> Void,
        leftAction: @escaping () -> Void,
        image: ImageAsset,
        showBackButton: Bool
    ) {
        self.buttonAction = buttonAction
        self.leftAction = leftAction
        self.image = image
        self.showBackButton = showBackButton
    }
    
    public var body: some View {
        HStack {
            HStack {
                if showBackButton {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 18)
                        .foregroundColor(.basicGray8)
                        .onTapGesture {
                            buttonAction()
                        }
                }
                
              
              Spacer()
                
                Circle()
                    .stroke(Color.basicBlack, style: .init(lineWidth: 1))
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image(asset: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    .onTapGesture {
                        leftAction()
                    }
                
            }
            
        }
        .padding(.horizontal, 20)
    }
}

