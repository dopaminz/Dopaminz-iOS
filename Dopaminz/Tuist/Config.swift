import ProjectDescription

let config = Config(
    compatibleXcodeVersions: ["15.3"],
    swiftVersion: "5.9.0",
    plugins: [
        .local(path: .relativeToRoot("Plugins/ProjectTemplatePlugin")),
        .local(path: .relativeToRoot("Plugins/DependencyPackagePlugin")),
        .local(path: .relativeToRoot("Plugins/DependencyPlugin")),
    ],
    generationOptions: .options()
)
