# GeeTest OneLogin Swift Package

Swift Package Manager distribution for the GeeTest OneLogin iOS SDK.

## Installation

In Xcode:

1. Open the app project.
2. Choose **File > Add Package Dependencies**.
3. Paste the Git URL for this repository.
4. Select a version tag.
5. Add the package product named `OneLoginSDK` to the app target.
6. Copy `OneLoginResource.bundle` from `Sources/Wrapper/Resources/` into your app project.
7. Add that copied bundle to the app target's **Copy Bundle Resources** phase so `OneLoginResource.bundle` is copied to the app bundle root.

Use a version tag for production integrations. Branch-based package dependencies are useful only for local evaluation.

`OneLoginResource.bundle` must be present at the app bundle root because the proprietary SDK loads it from the main bundle.

## Usage

Import the SDK from Swift:

```swift
import OneLoginSDK
```

Follow the GeeTest OneLogin iOS deployment guide for registration, initialization, carrier flow, and server-side token validation:

https://docs.geetest.com/onelogin/deploy/ios

## Example

The repository includes a sample app at:

```text
Example/OneLoginExample-Swift.xcodeproj
```

Open the project in Xcode, select the `OneLoginExample-Swift` scheme, and build it for an iOS simulator or device. The example uses the local Swift package product `OneLoginSDK`.
