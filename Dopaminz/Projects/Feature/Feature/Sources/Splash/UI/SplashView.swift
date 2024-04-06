//
//  SplashView.swift
//  Feature
//
//  Created by 서원지 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture

public struct SplashView: View {
  
  // MARK: - Properties
  
  @State private var ddang1Offset: CGFloat = -500
  
  
  // MARK: - Views
  
  public var body: some View {
    VStack(spacing: 16) {
      Image(asset: .logo)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 40)
      
      HStack(spacing: 4) {
        Image(asset: .ddang1)
          .offset(y: ddang1Offset)
        Image(asset: .ddang2)
        Image(asset: .ddang3)
      }
    }
    .background(Color.white.ignoresSafeArea())
    .onAppear {
      withAnimation(.spring(duration: 0.3, bounce: 0.2)) {
        ddang1Offset = 0
      }
    }
  }
}
