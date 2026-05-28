---
name: unit-test-xctest
description: >-
  Writes XCTest unit tests with protocol mocks for ViewModels and UseCases in
  the measurement iOS app. Use when adding or updating unit tests in
  StartKitTests, mocking repositories or use cases, or testing async MainActor code.
---

# Unit tests (XCTest)

## Stack

- Target: **StartKitTests**
- Framework: **XCTest** (`XCTestCase`, `XCTAssert*`) — not Swift Testing
- Import: `@testable import StartKit`

## Structure

```
StartKitTests/
├── Mocks/           # Manual protocol mocks
└── UnitTests/       # *Tests.swift files
```

## ViewModel test pattern

```swift
final class FooViewModelTests: XCTestCase {
    @MainActor
    func testLoadSuccess_setsFoo() async {
        let expected = Foo(id: "1", content: "x")
        let mock = MockGetFooUseCase(outcome: .success(expected))
        let sut = FooViewModel(getFooUseCase: mock)

        await sut.load(id: "1")

        XCTAssertEqual(sut.foo, expected)
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(mock.receivedIds, ["1"])
    }

    @MainActor
    func testLoadFailure_setsError() async {
        struct DummyError: Error {}
        let mock = MockGetFooUseCase(outcome: .failure(DummyError()))
        let sut = FooViewModel(getFooUseCase: mock)

        await sut.load(id: "missing")

        XCTAssertNil(sut.foo)
        XCTAssertNotNil(sut.errorMessage)
    }
}
```

## Mock pattern

```swift
@MainActor
final class MockGetFooUseCase: GetFooUseCase {
    enum Outcome {
        case success(Foo)
        case failure(Error)
    }

    private let outcome: Outcome
    private(set) var receivedIds: [String] = []

    init(outcome: Outcome) {
        self.outcome = outcome
    }

    func execute(id: String) async throws -> Foo {
        receivedIds.append(id)
        switch outcome {
        case .success(let foo): return foo
        case .failure(let error): throw error
        }
    }
}
```

## Rules

- Test **behavior**, not implementation details (avoid testing private methods).
- One logical assertion group per test method name (`testLoadFailure_setsError`).
- Use `@MainActor` on tests that touch ViewModels.
- No real Realm in unit tests unless explicitly an integration test suite.

## CI tip

If flaky simulator issues: `xcodebuild ... -parallel-testing-enabled NO -only-testing:StartKitTests`
