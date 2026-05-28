---
name: feature-slice
description: >-
  Adds a new feature as a vertical slice in the measurement iOS app: Domain
  entity and UseCase, Data repository and Realm DTO, Presentation ViewModel and
  View, DIContainer wiring, and tests. Use when implementing a new screen,
  flow, or business capability end-to-end.
---

# Feature slice

## Workflow

1. Read [measurement-domain](../measurement-domain/SKILL.md) for terms and rules.
2. Implement **Domain** → **Data** → **Presentation** → **DI** → **Tests** (never skip layers).
3. Run [architecture-guardrails](../architecture-guardrails/SKILL.md) check before finishing.

## Checklist

```
Domain  → see domain-usecase
- [ ] Entity struct (Equatable, Sendable where appropriate)
- [ ] Error enum in Domain/Entities/
- [ ] Repository protocol in Domain/Interfaces/
- [ ] UseCase protocol + Impl in Domain/UseCases/

Data    → see realm-data
- [ ] Realm DTO in Data/DTOs/ with toDomain()
- [ ] RepositoryImpl in Data/Repositories/
- [ ] RealmProvider / migration if schema changes

Presentation → see presentation-swiftui
- [ ] ViewModel @Observable @MainActor — UseCase via init only
- [ ] View — UI only; navigation via AppCoordinator
- [ ] Reusable pieces in Presentation/Components/
- [ ] AppCoordinator.Route + navigationDestination if new screen

Shared  → see di-container
- [ ] DIContainer: wire repository → useCase → makeXxxViewModel()

Tests   → see unit-test-xctest, snapshot-test, ui-test-xcuitest
- [ ] Mock protocol in StartKitTests/Mocks/
- [ ] XCTest for ViewModel (and UseCase if non-trivial)
- [ ] Snapshot only for stable visual components
- [ ] XCUITest for critical path
```

## Naming

Use the naming table in [foundation/reference.md](../foundation/reference.md#naming-conventions).

| Concern | Example |
|---------|---------|
| Entity | `InspectionRecord` |
| DTO | `RealmInspectionRecord` |
| Repository | `InspectionRecordRepository` / `InspectionRecordRepositoryImpl` |
| UseCase | `SubmitInspectionRecordUseCase` / `SubmitInspectionRecordUseCaseImpl` |
| Module folder | `Presentation/Modules/Inspection/` |

## Reference implementation

Copy patterns from `ExampleData`, `ExampleViewModel`, `ExampleView`, `GetExampleDataUseCase`, `ExampleDataRepositoryImpl`, `RealmExampleData`.

## Do not

- Create a “misc” or `Utils` folder for business logic.
- Add Realm calls in ViewModel “just once” for speed.
- Ship a feature without at least ViewModel unit tests.
