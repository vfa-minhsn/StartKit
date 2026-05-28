---
name: snapshot-test
description: >-
  Records and compares SwiftUI component snapshots using swift-snapshot-testing
  and XCTest in StartKitTests. Use when adding visual regression tests for
  views or reusable UI components.
---

# Snapshot tests

## Stack

- **XCTest** + **SnapshotTesting** (Point-Free, SPM)
- `UIHostingController` to render SwiftUI

## Example

```swift
final class FooViewSnapshotTests: XCTestCase {
    @MainActor
    func testFooView_default() async throws {
        let viewModel = FooViewModel(getFooUseCase: MockGetFooUseCase(data: .fixture))
        await viewModel.load(id: "example")

        let hosting = UIHostingController(rootView: FooView(viewModel: viewModel, coordinator: AppCoordinator()))
        hosting.view.bounds = CGRect(x: 0, y: 0, width: 390, height: 844)
        hosting.view.layoutIfNeeded()
        try await Task.sleep(for: .milliseconds(200))

        assertSnapshot(
            of: hosting,
            as: .image(precision: 0.96, perceptualPrecision: 0.98),
            named: "default",
            record: .never
        )
    }
}
```

## Snapshot paths (XCTest)

`StartKitTests/.../__Snapshots__/<TestClassName>/test<MethodName>.<named>.png`

Renaming test methods **breaks** reference paths — re-record after rename.

## Recording new references

1. Set `record: .missing` temporarily.
2. Run test once (may fail while recording).
3. Commit generated PNG.
4. Set `record: .never` for CI.

## When to snapshot

- Reusable components and stable “loaded” screen layouts.
- **Not** for every screen if data-driven UI changes often—prefer ViewModel unit tests.

## Stability

- Fixed `bounds`, light mode unless testing dark explicitly.
- Use `.serialized` suite or disable parallel testing if flakes occur.
