//
//  Project+Enviorment.swift
//  Plugins
//
//  Created by 서원지 on 4/4/24.
//

import Foundation
import ProjectDescription

public extension Project {
    enum Environment {
        public static let appName = "Dopaminz"
        public static let appDevName = "Dopaminz-Dev"
        public static let organizationName = "Wonji suh"
        public static let organizationTeamId = "N94CS4N6VR"
        public static let deploymentTarget = DeploymentTargets(iOS: "17.0")
        public static let deploymentDestination: Destinations = [.iPhone]
        public static let bundlePrefix = "com.Unit.Dopaminz"
        public static let appVersion = "1.0.0"
    }
}


