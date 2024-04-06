//
//  FontStyle.swift
//  DesignSystem
//
//  Created by 이승기 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI

public extension Font {
  static var headline1: Font { .pretendardFontFamily(family: .Bold, size: 24) }
  static var headline2: Font { .pretendardFontFamily(family: .Bold, size: 22) }
  static var headline3: Font { .pretendardFontFamily(family: .Bold, size: 20) }
  static var headline4: Font { .pretendardFontFamily(family: .Bold, size: 18) }
  static var caption: Font { .pretendardFontFamily(family: .Regular, size: 12) }
  static var headline5_SemiBold: Font { .pretendardFontFamily(family: .SemiBold, size: 16) }
  static var headline6_Medium: Font { .pretendardFontFamily(family: .Medium, size: 16) }
  static var body_Medium: Font { .pretendardFontFamily(family: .Medium, size: 16) }
  static var body_Regular: Font { .pretendardFontFamily(family: .Regular, size: 16) }
  static var body2_Medium: Font { .pretendardFontFamily(family: .Medium, size: 15) }
  static var body2_Regular: Font { .pretendardFontFamily(family: .Regular, size: 15) }
  static var body3_Medium: Font { .pretendardFontFamily(family: .Medium, size: 14) }
  static var body3_Regular: Font { .pretendardFontFamily(family: .Regular, size: 14) }
}
