import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin
import DependencyPackagePlugin

let project = Project.makeAppModule(
    name: "Feature",
    bundleId: .appBundleID(name: ".Feature"),
    product: .staticFramework,
    settings:  .settings(),
    dependencies: [
        .Shared(implements: .Shareds),
        .Networking(implements: .Networkings)
        
    ],
    sources: ["Sources/**"]
)

