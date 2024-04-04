import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeAppModule(
    name: "Service",
    bundleId: .appBundleID(name: ".Service"),
    product: .staticFramework,
    settings:  .settings(),
    dependencies: [
        .Networking(implements: .ThirdPartys),
        .Networking(implements: .API),
        .sdk(name: "OSLog", type: .framework)
    ],
    sources: ["Sources/**"]
)

