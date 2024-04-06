//
//  CustomButton.swift
//  DesignSystem
//
//  Created by 이승기 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI

public struct CustomButton: View {
  
  // MARK: - Properties
  
  @Binding var isDisabled: Bool
  private let title: String
  private let action: () -> Void
  
  
  // MARK: - Initializers
  
  public init(
    isDisabled: Binding<Bool>,
    title: String,
    action: @escaping () -> Void
  ) {
    _isDisabled = isDisabled
    self.title = title
    self.action = action
  }
  
  
  // MARK: - Views
  
  public var body: some View {
    Button(action: action) {
      Text(title)
        .font(.headline5_SemiBold)
        .foregroundColor(isDisabled ? Color.gray800 : .white)
        .padding()
        .frame(maxWidth: .infinity)
    }
    .frame(minHeight: 52)
    .background(isDisabled ? Color.gray100 : Color.blue500)
    .clipShape(RoundedRectangle(cornerRadius: 6))
    .disabled(isDisabled)
  }
}
