---
name: presentation-swiftui
description: >-
  Builds SwiftUI screens with MVVM: Observable ViewModels, thin Views, and
  AppCoordinator navigation for the measurement iPhone app. Use when creating
  views, view models, reusable components, or navigation flows.
---

# Presentation (SwiftUI)

## ViewModel

- `@Observable` + `@MainActor` + `final class`.
- Inject **UseCase protocols** only via `init`.
- Expose UI state: `isLoading`, `errorMessage`, domain models with `private(set)`.
- Async entry points: `func load(...)` / `func submit(...)` — no Realm, no repository.

## View

- Use `@Bindable` for ViewModel when needed.
- Receive `AppCoordinator` for navigation (do not use global singletons).
- **No** business rules in `body` — only layout and calling ViewModel/coordinator.
- User-visible strings: English + `String(localized:)` — see [localization](../localization/SKILL.md).
- Add `accessibilityIdentifier` on controls targeted by XCUITest.

## Navigation

- `AppCoordinator` holds `NavigationPath` and `Route` enum.
- `RootView`: `NavigationStack(path: $coordinator.path)` + `.navigationDestination(for: Route.self)`.
- New screen → new `Route` case + destination view.

## Components

- Shared controls in `Presentation/Components/` (e.g. `PrimaryButton`).
- Keep components **dumb**: title + action closure; no UseCase inside generic components.

## UIKit

Use UIKit only when SwiftUI cannot meet the requirement (document why in PR). Wrap in `UIViewControllerRepresentable` at the edge.

## Testing

- ViewModel: [unit-test-xctest](../unit-test-xctest/SKILL.md)
- Visual components: [snapshot-test](../snapshot-test/SKILL.md)
- Flows: [ui-test-xcuitest](../ui-test-xcuitest/SKILL.md)
