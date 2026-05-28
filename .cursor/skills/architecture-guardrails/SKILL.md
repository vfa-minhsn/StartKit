---
name: architecture-guardrails
description: >-
  Enforces Clean Architecture layer boundaries for the measurement iOS app: no
  Realm in Presentation/Domain, no business logic in Views, repository-only data
  access. Use before implementing features, during code review, or when
  refactoring imports and dependencies.
---

# Architecture guardrails

## Import matrix

| Layer | Allowed | Forbidden |
|-------|---------|-----------|
| **Domain** | `Foundation` | `SwiftUI`, `UIKit`, `RealmSwift` |
| **Data** | `RealmSwift`, Domain protocols | `SwiftUI` |
| **Presentation** | `SwiftUI`, Domain UseCase **protocols** | `RealmSwift`, DTOs, `RealmProvider` |
| **ViewModel** | UseCase protocols, Domain entities | Repository impl, Realm types |

## Hard rules

1. **Realm** lives only in `Data/` (DTOs, `RealmProvider`, `*RepositoryImpl`).
2. **Map** `RealmObject` → domain `struct` via `toDomain()` before leaving Data.
3. **ViewModels** call **UseCases**, never repositories or `realm.write` directly.
4. **Views** render state and forward user actions; **no** validation rules, persistence, or workflow branching that belongs in UseCases.
5. **No singletons** for repositories or network clients — use `DIContainer`.
6. **No Objective-C** sources or bridging headers unless explicitly approved.

## Allowed in Views

- Layout, animations, `@Bindable` / bindings
- Calling `viewModel.load(...)` or `coordinator.goTo...()`
- Local UI-only state (sheet presented, focus, scroll)

## Red flags (stop and refactor)

- `import RealmSwift` outside `Data/`
- `if/else` chains > 3 levels in View `body`
- ViewModel > ~200 lines or mixing navigation + persistence + formatting rules
- Returning `Object` subclasses to Presentation
- Copy-pasted VB.NET “button click” procedures as one Swift function

## Quick check commands

Realm leakage outside Data layer:

```bash
# with ripgrep
rg "import RealmSwift" StartKit --glob "*.swift" | rg -v "/Data/"

# fallback with grep
grep -R --include="*.swift" "import RealmSwift" StartKit | grep -v "/Data/"
```

Any match outside `Data/` is a **blocker**.

SwiftUI in Domain layer:

```bash
rg "import SwiftUI" StartKit/Domain --glob "*.swift" || echo "OK"
```
