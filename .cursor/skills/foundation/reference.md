# Foundation — Reference

## Project requirements (summary)

- Replace Windows tablet measurement business system with iPhone app.
- iPhone 16e+, iOS 26.0+, portrait only.
- Realm via Repository; View/ViewModel must not depend on Realm directly.
- Business logic independent of Realm implementation details.
- Swift only; no Objective-C.
- No business logic in SwiftUI Views (screen/display state allowed).
- MVVM + UseCase + Repository + Coordinator.
- Small testable modules; no deep nesting or VB.NET-style structure port.

## Data flow

```text
View → ViewModel → UseCase → Repository (protocol) → RepositoryImpl → Realm DTO → Domain Entity
```

Reverse mapping (write): `Input on View → ViewModel → UseCase → Repository → RepositoryImpl maps Domain → DTO → realm.write`.

## Naming conventions

| Concern | Format | Example |
|---------|--------|---------|
| Domain entity | `<Concept>` | `InspectionRecord` |
| Domain error | `<Concept>Error` | `InspectionRecordError` |
| Repository protocol | `<Concept>Repository` | `InspectionRecordRepository` |
| Repository impl | `<Concept>RepositoryImpl` | `InspectionRecordRepositoryImpl` |
| Realm DTO | `Realm<Concept>` | `RealmInspectionRecord` |
| UseCase protocol | `<Verb><Concept>UseCase` | `SubmitInspectionRecordUseCase` |
| UseCase impl | `<Verb><Concept>UseCaseImpl` | `SubmitInspectionRecordUseCaseImpl` |
| Module folder | `Presentation/Modules/<Concept>/` | `Presentation/Modules/Inspection/` |
| ViewModel | `<Concept>ViewModel` | `InspectionViewModel` |
| View | `<Concept>View` | `InspectionView` |
| Test file | `<Concept>Tests.swift` | `InspectionViewModelTests.swift` |
| Mock | `Mock<Type>` | `MockSubmitInspectionRecordUseCase` |
| Accessibility id | `<screen>.<element>` | `inspection.submitButton` |

## File templates

See individual skills:
- [domain-usecase](../domain-usecase/SKILL.md)
- [realm-data](../realm-data/SKILL.md)
- [presentation-swiftui](../presentation-swiftui/SKILL.md)
- [unit-test-xctest](../unit-test-xctest/SKILL.md)
