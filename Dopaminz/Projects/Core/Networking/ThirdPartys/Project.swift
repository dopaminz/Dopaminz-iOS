import Foundation
import ProjectDescription
import ProjectTemplatePlugin
import DependencyPackagePlugin


let project = Project.makeAppModule(
    name: "ThirdPartys",
    bundleId: .appBundleID(name: ".ThirdPartys"),
    product: .staticFramework,
    settings:  .settings(),
    dependencies: [
        .SPM.combineMoya,
        .SPM.moya,
        .SPM.keychainAccess
    ],
    sources: ["Sources/**"]
)

