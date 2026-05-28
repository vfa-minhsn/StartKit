---
name: foundation
description: >-
  Project charter and folder layout for the iPhone measurement-management app
  (MVVM + UseCase + Repository + Coordinator, Realm in Data only, SwiftUI,
  portrait iOS). Use at the start of any task in this repository or when
  onboarding to the codebase.
---

# Foundation

## Charter

- **Goal**: Replace Windows-tablet measurement business management with an iPhone app.
- **Platform**: iPhone 16e+, iOS 26.0+, **portrait only**, Swift 6, **no Objective-C**.
- **Persistence**: Realm (SPM); **only `Data/`** imports `RealmSwift`.
- **UI**: SwiftUI default; UIKit only when SwiftUI is not viable.
- **Architecture**: MVVM + UseCase + Repository + Coordinator; `DIContainer` constructor injection.
- **Quality**: Business logic in UseCases; unit-tested modules; testable UI components; English UI strings.
- **Reject**: Deep nesting, tight coupling, god classes, copying VB.NET structural problems.

## Folder layout

```
StartKit/
├── App/              # @main, RootView, AppState
├── Domain/           # Entities, Interfaces, UseCases — Foundation only
├── Data/             # DTOs, DataSources, Repository implementations
├── Presentation/     # Coordinators, Modules, Components
└── Shared/           # DIContainer, Extensions

StartKitTests/        # XCTest, snapshots, Mocks/
StartKitUITests/      # XCUITest
```

Template vertical slice: **ExampleData** (`ExampleView`, `ExampleViewModel`, `GetExampleDataUseCase`, `RealmExampleData`).

## Related skills

### Core (read first)

- [architecture-guardrails](../architecture-guardrails/SKILL.md) — layer rules and red flags
- [measurement-domain](../measurement-domain/SKILL.md) — business vocabulary and rules

### Building a feature

- [feature-slice](../feature-slice/SKILL.md) — end-to-end checklist
- [domain-usecase](../domain-usecase/SKILL.md) — entities, UseCases
- [realm-data](../realm-data/SKILL.md) — DTOs, repositories
- [presentation-swiftui](../presentation-swiftui/SKILL.md) — Views, ViewModels, navigation
- [di-container](../di-container/SKILL.md) — wiring

### Testing & review

- [unit-test-xctest](../unit-test-xctest/SKILL.md) — XCTest patterns
- [snapshot-test](../snapshot-test/SKILL.md) — SwiftUI snapshots
- [ui-test-xcuitest](../ui-test-xcuitest/SKILL.md) — XCUITest flows
- [code-review](../code-review/SKILL.md) — PR rubric

### Migration & legacy

- [vbnet-migration](../vbnet-migration/SKILL.md) — porting VB.NET logic
- [legacy-parity](../legacy-parity/SKILL.md) — parity checklist

### Ops & extensions

- [network-sync](../network-sync/SKILL.md) — HTTP, offline-first
- [realm-migration-versioning](../realm-migration-versioning/SKILL.md) — schema upgrades
- [device-deployment](../device-deployment/SKILL.md) — device builds, Realm embed
- [localization](../localization/SKILL.md) — UI copy policy

Quick references and naming table: [reference.md](reference.md)
