//
//  SVGImgProcessor.swift
//  DesignSystem
//
//  Created by 서원지 on 4/5/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import SVGKit
import Kingfisher

public struct SVGImgProcessor:ImageProcessor {
    
    public var identifier: String = "com.appidentifier.webpprocessor"
    
    public init(identifier: String = "com.appidentifier.webpprocessor") {
        self.identifier = identifier
    }
    
    public func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            print("already an image")
            return image
        case .data(let data):
            let imsvg = SVGKImage(data: data)
            return imsvg?.uiImage
        }
    }
}
