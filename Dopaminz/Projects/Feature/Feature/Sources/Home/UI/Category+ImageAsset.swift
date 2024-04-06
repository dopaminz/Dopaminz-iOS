//
//  Category+MakeCategoryImage.swift
//  Feature
//
//  Created by 이승기 on 4/7/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import DesignSystem
import Model

extension PollCategory {
  public var imageAsset: ImageAsset {
    switch self {
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
    case .relationships:
        .category_love
    case .gender:
        .category_gender
    case .etc:
        .category_etc
    }
  }
}
