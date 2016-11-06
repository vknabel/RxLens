import PackageDescription

let package = Package(
    name: "RxLens",
    dependencies: [
        .Package(url: "https://github.com/ReactiveX/RxSwift.git", majorVersion: 3),

        // Test dependencies
        .Package(url: "https://github.com/Quick/Quick.git", majorVersion: 0, minor: 10)
    ]
)
