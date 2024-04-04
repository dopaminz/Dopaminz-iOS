//
//  PretendardFont.swift
//  DesignSystem
//
//  Created by 서원지 on 4/4/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import UIKit
import SwiftUI

public enum PretendardFontFamily: CustomStringConvertible {
    case Black, Bold, ExtraBold, ExtraLight, Light, Medium, Regular, SemiBold, Thin
    
    public var description: String {
        switch self {
        case .Black:
            return "Black"
        case .Bold:
            return "Bold"
        case .ExtraBold:
            return "ExtraBold"
        case .ExtraLight:
            return "ExtraLight"
        case .Light:
            return "Light"
        case .Medium:
            return "Medium"
        case .Regular:
            return "Regular"
        case .SemiBold:
            return "SemiBold"
        case .Thin:
            return "Thin"
        }
    }
}


public struct PretendardFont: ViewModifier {
    public var family: PretendardFontFamily
    public var size: CGFloat
    
    public func body(content: Content) -> some View {
        return content.font(.custom("PretendardVariable-\(family)", fixedSize: size))
    }
}

public extension View {
    func pretendardFont(family: PretendardFontFamily, size: CGFloat) -> some View {
        return self.modifier(PretendardFont(family: family, size: size))
    }
}

public extension UIFont {
    static func pretendardFontFamily(family: PretendardFontFamily, size: CGFloat) -> Font{
        let font = Font.custom("PretendardVariable-\(family)", size: size)
        return font
    }
}

public extension Font {
    static func pretendardFontFamily(family: PretendardFontFamily, size: CGFloat) -> Font{
        let font = Font.custom("PretendardVariable-\(family)", size: size)
        return font
    }
}


