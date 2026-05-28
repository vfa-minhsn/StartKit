---
name: domain-usecase
description: >-
  Writes Domain entities, repository protocols, and UseCases with pure Swift
  business logic for the measurement app—no Realm or SwiftUI. Use when
  implementing rules, validation, workflows, or orchestrating repository calls.
---

# Domain & UseCase

## Responsibilities

- **Entities**: immutable-friendly `struct`s, no framework types.
- **Interfaces**: repository protocols only (`async throws`).
- **UseCases**: one clear capability per type (e.g. `LoadSessionUseCase`, `SubmitMeasurementUseCase`).

## Rules

- **No** `import RealmSwift`, `import SwiftUI`, `import UIKit`.
- Mark UI-facing orchestration types `@MainActor` when consumed by ViewModels on main actor.
- Throw **domain errors** (`enum FooError: Error`), not `NSError` with magic codes.
- Prefer **guard** and early return; extract helpers instead of nested loops/branches.
- Keep UseCases **small**; compose multiple UseCases in ViewModel or a facade UseCase if needed.

## UseCase template

```swift
@MainActor
protocol SubmitMeasurementUseCase {
    func execute(_ input: MeasurementInput) async throws -> MeasurementResult
}

@MainActor
final class SubmitMeasurementUseCaseImpl: SubmitMeasurementUseCase {
    private let repository: MeasurementRepository

    init(repository: MeasurementRepository) {
        self.repository = repository
    }

    func execute(_ input: MeasurementInput) async throws -> MeasurementResult {
        guard input.isValid else { throw MeasurementError.invalidInput }
        return try await repository.save(input)
    }
}
```

## Testing

- Test UseCases with **mock repositories** (XCTest in `StartKitTests`).
- Cover: success, each error path, boundary values from [measurement-domain](../measurement-domain/SKILL.md).

## VB.NET migration

When porting legacy logic, extract **rules** into UseCase methods with names that match domain language—not button handler names. See [vbnet-migration](../vbnet-migration/SKILL.md).
