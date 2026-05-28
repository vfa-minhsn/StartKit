---
name: device-deployment
description: >-
  Configures iPhone device builds for the measurement app including RealmSwift
  embed, debug dylib settings, portrait-only, and simulator vs device targets.
  Use when fixing dyld framework errors, TestFlight builds, or on-device debugging.
---

# Device deployment

## Common issue: RealmSwift not loaded

**Symptom**: `Library not loaded: @rpath/RealmSwift.framework/RealmSwift`

**Fixes in this project**:

1. **Embed Frameworks** build phase on target `StartKit` includes `RealmSwift` with **Code Sign on Copy**.
2. `ENABLE_DEBUG_DYLIB = NO` on app target (Debug + Release).
3. Clean build folder, delete app on device, reinstall.

## Verify embed

After build, check the framework lands inside the app bundle:

```bash
ls ~/Library/Developer/Xcode/DerivedData/StartKit-*/Build/Products/Debug-iphoneos/StartKit.app/Frameworks/RealmSwift.framework
```

If the path is missing, the Embed Frameworks phase is broken.

## Target settings (reference)

- iOS deployment target: `IPHONEOS_DEPLOYMENT_TARGET = 26.0` (app target)
- `TARGETED_DEVICE_FAMILY = 1` (iPhone)
- Portrait only: `INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = UIInterfaceOrientationPortrait`
- Swift 6 + `SWIFT_STRICT_CONCURRENCY = complete`
- `ENABLE_DEBUG_DYLIB = NO`

## SPM

- Realm via `realm-swift` package; resolve packages after clone.
- If CI fails to resolve: `xcodebuild -resolvePackageDependencies`.

## Debugging on device

- Trust the developer certificate on device.
- Match iOS deployment target with device OS (iOS 26.0+, iPhone 16e+).

## Simulator vs device

Simulator may pass while device fails when embed/signing is missing — always rebuild for **generic/platform=iOS** or a physical device after touching Realm or other dynamic frameworks.
