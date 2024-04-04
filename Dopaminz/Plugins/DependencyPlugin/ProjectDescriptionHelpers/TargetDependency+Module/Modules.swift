//
//  Modules.swift
//  Plugins
//
//  Created by 서원지 on 4/4/24.
//

import Foundation
import ProjectDescription

public enum ModulePath {
    case Feature(Features)
    case Core(Cores)
    case Networking(Networkings)
    case Shared(Shareds)
}


// MARK: FeatureModule
public extension ModulePath {
    enum Features: String, CaseIterable {
        case Feature
        
        public static let name: String = "Feature"
    }
}

//MARK: -  CoreMoudule
public extension ModulePath {
    enum Cores: String, CaseIterable {
        case Core
        
        public static let name: String = "Core"
    }
}

//MARK: -  CoreDomainModule
public extension ModulePath {
    enum Networkings: String, CaseIterable {
        case API
        case Networkings
        case Model
        case Service
        case DiContainer
        case ThirdPartys
        
        
        public static let name: String = "Networking"
    }
}

public extension ModulePath {
    enum Shareds: String, CaseIterable {
        case Shareds
        case DesignSystem
        case ThirdParty
        
        public static let name: String = "Shared"
    }
}



