//
//  TargetDependency+Modules.swift
//  Plugins
//
//  Created by 서원지 on 4/4/24.
//

import Foundation
import ProjectDescription


// MARK: TargetDependency + Feature
public extension TargetDependency {
    static func Feature(implements module: ModulePath.Features) -> Self {
        return .project(target: module.rawValue, path: .Feature(implementation: module))
    }
}

// MARK: TargetDependency + Design
public extension TargetDependency {
    static func Shared(implements module: ModulePath.Shareds) -> Self {
        return .project(target: module.rawValue, path: .Shared(implementation: module))
    }
}

// MARK: TargetDependency + Core
public extension TargetDependency {
    static func Core(implements module: ModulePath.Cores) -> Self {
        return .project(target: module.rawValue, path: .Core(implementation: module))
    }
}


// MARK: TargetDependency + Domain

public extension TargetDependency {
    static func Networking(implements module: ModulePath.Networkings) -> Self {
        return .project(target: module.rawValue, path: .Networking(implementation: module))
    }
}




