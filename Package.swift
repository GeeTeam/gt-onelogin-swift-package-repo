// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "gt-onelogin-swift-package",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "OneLoginSDK",
            targets: ["OneLoginSDKWrapper"]
        )
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "OneLoginSDKBinary",
            path: "Sources/OneLoginSDK.xcframework"
        ),
        .binaryTarget(
            name: "EAccountApiSDKBinary",
            path: "Sources/EAccountApiSDK.xcframework"
        ),
        .binaryTarget(
            name: "OAuthBinary",
            path: "Sources/OAuth.xcframework"
        ),
        .binaryTarget(
            name: "TYRZUISDKBinary",
            path: "Sources/TYRZUISDK.xcframework"
        ),
        .target(
            name: "OneLoginSDKWrapper",
            dependencies: [
                "OneLoginSDKBinary",
                "EAccountApiSDKBinary",
                "OAuthBinary",
                "TYRZUISDKBinary"
            ],
            path: "Sources/Wrapper",
            resources: [
                .copy("Resources/OneLoginResource.bundle")
            ]
        )
    ]
)
