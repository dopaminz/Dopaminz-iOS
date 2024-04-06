//
//  Extension+TargetDependency.swift
//  Plugins
//
//  Created by 서원지 on 4/4/24.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let moya = TargetDependency.external(name: "Moya", condition: .none)
    static let combineMoya = TargetDependency.external(name: "CombineMoya", condition: .none)
    static let composableArchitecture = TargetDependency.external(name: "ComposableArchitecture", condition: .none)
    static let swinject = TargetDependency.external(name: "Swinject", condition: .none)
    static let sdwebImage = TargetDependency.external(name: "SDWebImageSwiftUI", condition: .none)
    static let swiftJWT = TargetDependency.external(name: "SwiftJWT", condition: .none)
   
    static let keychainAccess = TargetDependency.external(name: "KeychainAccess", condition: .none)
    
    static let popupView = TargetDependency.external(name: "PopupView", condition: .none)
    
}


