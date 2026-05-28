---
name: ui-test-xcuitest
description: >-
  Writes XCUITest UI tests for the measurement iPhone app using XCUIApplication
  and accessibility identifiers. Use for end-to-end flows, launch tests, and
  verifying critical user journeys on simulator or device.
---

# UI tests (XCUITest)

## Stack

- Target: **StartKitUITests**
- `import XCTest` — `XCTestCase`, `XCUIApplication`

## Identifiers

Set in SwiftUI:

```swift
Button("Open detail") { ... }
    .accessibilityIdentifier("example.openDetail")
```

Query in tests:

```swift
XCTAssertTrue(app.buttons["example.openDetail"].exists)
```

Prefer **identifiers** over localized label text when labels may change.

## Test pattern

```swift
final class FooUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testFooScreen_displaysData() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["ExpectedTitle"].waitForExistence(timeout: 5))
    }
}
```

## Launch tests

`StartKitUITestsLaunchTests` captures launch screenshots (light/dark). Keep minimal—no business assertions required there.

## Scope

- Critical paths: login/work order/measurement submit (as spec defines).
- **Not** a replacement for ViewModel unit tests.

## Stability

- Wait with `waitForExistence(timeout:)` for async loads.
- Reset app state via launch arguments if adding test hooks later (`app.launchArguments`).
