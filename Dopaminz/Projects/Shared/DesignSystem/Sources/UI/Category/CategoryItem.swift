//
//  CategoryItem.swift
//  DesignSystem
//
//  Created by 이승기 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import Model

struct CategoryItem: View {
  
  // MARK: - Properties
  
  private let category: PollCategory
  @State private var isSelected = false
  private let onTapHandler: (Bool) -> Void
  
  
  // MARK: - Initializer
  
  init(category: PollCategory,
       isSelected: Bool,
       onTapHandler: @escaping (Bool) -> Void) {
    self.category = category
    _isSelected = .init(initialValue: isSelected)
    self.onTapHandler = onTapHandler
  }
  
  
  // MARK: - Views
  
  var body: some View {
    Button {
      isSelected.toggle()
      onTapHandler(isSelected)
    } label: {
      HStack(spacing: 8) {
        Image(asset: makeImage(with: category))
          .resizable()
          .frame(width: 35, height: 35)
        
        Text(category.desc)
          .font(.pretendardFontFamily(family: .Medium, size: 18))
          .foregroundStyle(Color.black)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding(.vertical, 12)
      .padding(.horizontal, 16)
      .background {
        RoundedRectangle(cornerRadius: 8)
          .fill(isSelected ? Color.blue50 : Color.gray50)
      }
      .overlay {
        if isSelected {
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.blue400)
        }
      }
    }
  }
}

extension CategoryItem {
  func makeImage(with category: PollCategory) -> ImageAsset {
    switch category {
    case .all:
        .category_all
    case .politics:
        .category_politics
    case .region:
        .category_region
    case .economy:
        .category_economy
    case .generation:
        .category_generation
    case .love:
        .category_love
    case .gender:
        .category_gender
    case .etc:
        .category_etc
    }
  }
}
