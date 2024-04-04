//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 4/4/24.
//

import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

// Local plugin loaded

let project = Project.makeAppModule(
    name: Project.Environment.appName,
    bundleId: .mainBundleID(),
    product: .app,
    settings: .appMainSetting,
    scripts: [],
    dependencies: [
        .Core(implements: .Core),
        .Shared(implements: .Shareds),
        
    ],
    sources: ["Sources/**", "Resources/FontAsset/**"],
    resources: ["Resources/**", "../Support/PrivacyInfo.xcprivacy"],
    infoPlist: .file(path: "../Support/Info.plist"),
    entitlements: .file(path: "../Entitlements/Dopaminz.entitlements")
    
)


