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
import DesignSystem

public struct SplashView: View {
  
  // MARK: - Properties
  
  @State private var ddang1Offset: CGFloat = -500
  @State private var ddang2Offset: CGFloat = -500
  @State private var ddang3Offset: CGFloat = -500
  
    public init() {}
    
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
          .offset(y: ddang2Offset)
        
          Image(asset: .ddang3)
          .offset(y: ddang3Offset)
      }
    }
    .background(Color.white.ignoresSafeArea())
    .onAppear {
      withAnimation(.spring(duration: 0.3, bounce: 0.2)) {
        ddang1Offset = 0
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
        withAnimation(.spring(duration: 0.3, bounce: 0.2)) {
          ddang2Offset = 1
        }
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        withAnimation(.spring(duration: 0.3, bounce: 0.2)) {
          ddang3Offset = 2
        }
      }
      
    }
  }
}
