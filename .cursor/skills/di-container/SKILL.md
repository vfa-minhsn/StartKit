---
name: di-container
description: >-
  Wires dependencies in DIContainer using constructor injection for repositories,
  use cases, and view model factories in the measurement iOS app. Use when
  adding new services, refactoring dependencies, or preparing mocks for tests.
---

# DI container

## Principles

- **Single composition root**: `Shared/DI/DIContainer.swift`.
- **No** `static let shared` on repositories or network clients.
- Construct graph in `init`: `RealmProvider` → `RepositoryImpl` → `UseCaseImpl`.
- Expose factories: `func makeFooViewModel() -> FooViewModel`.

## Pattern (current codebase)

```swift
@Observable
@MainActor
final class DIContainer {
    let coordinator: AppCoordinator
    private let getExampleDataUseCase: GetExampleDataUseCase

    init(
        coordinator: AppCoordinator = AppCoordinator(),
        realmProvider: RealmProvider = RealmProvider(),
        exampleDataRepository: ExampleDataRepository? = nil,
        getExampleDataUseCase: GetExampleDataUseCase? = nil
    ) {
        self.coordinator = coordinator
        let repository = exampleDataRepository ?? ExampleDataRepositoryImpl(realmProvider: realmProvider)
        self.getExampleDataUseCase = getExampleDataUseCase ?? GetExampleDataUseCaseImpl(repository: repository)
    }

    func makeExampleViewModel() -> ExampleViewModel {
        ExampleViewModel(getExampleDataUseCase: getExampleDataUseCase)
    }
}
```

## App entry

`StartKitApp` holds `@State private var container = DIContainer()` and passes `.environment(container)`.

## Testing

- In XCTest, **do not** use production `DIContainer` with real Realm unless integration test is intended.
- Inject `MockGetXxxUseCase` directly into `ViewModel` or pass mocks into a test-only `DIContainer` initializer overload.

## Adding a feature

1. Private stored property for new UseCase.
2. Wire in `init` from new RepositoryImpl.
3. Add `makeXxxViewModel()`.
4. Call factory from `RootView` or parent module.
