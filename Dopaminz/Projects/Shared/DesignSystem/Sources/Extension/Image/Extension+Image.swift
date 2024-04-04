//
//  Extension+Image.swift
//  DesignSystem
//
//  Created by 서원지 on 4/4/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import UIKit
import SwiftUI

public extension UIImage {
    convenience init?(_ asset: ImageAsset) {
        self.init(named: asset.rawValue, in: Bundle.module, with: nil)
    }

    convenience init?(assetName: String) {
        self.init(named: assetName, in: Bundle.module, with: nil)
    }
}

public extension Image {
    init(asset: ImageAsset) {
        if let uiImage = UIImage(asset) {
            self.init(uiImage: uiImage)
        } else {
            self = Image(systemName: "questionmark")
        }
    }

    init(assetName: String) {
        if let uiImage = UIImage(assetName: assetName) {
            self.init(uiImage: uiImage)
        } else {
            self = Image(systemName: "questionmark")
        }
    }
}
