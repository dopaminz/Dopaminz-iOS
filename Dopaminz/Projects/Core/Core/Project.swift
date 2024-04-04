import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeAppModule(
    name: "Core",
    bundleId: .appBundleID(name: ".Core"),
    product: .staticFramework,
    settings:  .settings(),
    dependencies: [
        .Feature(implements: .Feature)
    ],
    sources: ["Sources/**"]
)

