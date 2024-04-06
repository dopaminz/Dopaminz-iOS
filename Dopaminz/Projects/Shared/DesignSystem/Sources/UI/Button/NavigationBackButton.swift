//
//  NavigationBackButton.swift
//  DesignSystem
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import SwiftUI

public struct NavigationBackButton: View {
    var buttonAction: () -> Void = { }
    
    public init(
        buttonAction: @escaping () -> Void
    ) {
        self.buttonAction = buttonAction
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
            
        }
        .padding(.horizontal, 20)
    }
}

