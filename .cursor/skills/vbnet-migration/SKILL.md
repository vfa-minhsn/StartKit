---
name: vbnet-migration
description: >-
  Migrates measurement business logic from legacy VB.NET Windows tablet code
  into Swift UseCases and small modules without copying deep nesting or tight
  coupling. Use when porting forms, workflows, or rules from the old system.
---

# VB.NET migration

## Goals

- Preserve **behavior** and domain rules, not file structure.
- End state: testable UseCases + Realm behind repositories.

## Process

1. **Document** legacy flow: inputs, outputs, validations, side effects (table or sequence).
2. **Name** Swift types in domain language ([measurement-domain](../measurement-domain/SKILL.md)).
3. **Extract rules** into UseCases — one responsibility per UseCase when possible.
4. **Map persistence** to Repository + Realm DTO — never port `DataSet` patterns to ViewModels.
5. **Add XCTest** per rule before or with implementation (characterization tests if needed).
6. **Verify** with [legacy-parity](../legacy-parity/SKILL.md) checklist.

## Anti-patterns (reject)

| Legacy (VB.NET style) | Swift replacement |
|----------------------|-------------------|
| One Form with 2000 lines | Module: View + ViewModel + UseCases |
| Button_Click with DB + validation + UI | UseCase + ViewModel state update |
| Global module state | Injected services via DIContainer |
| Deep nested If/Else | guard, early return, small functions |
| Copy-paste similar blocks | Shared UseCase or domain helper |

## Characterization test

When legacy spec is unclear:

```swift
// Given inputs from old system examples, assert outputs match documented legacy results
func testLegacyCase_xyz() async throws { ... }
```

## UI migration

- One legacy **screen** ≈ one SwiftUI **module** + coordinator route.
- Split wizard-style VB forms into steps with explicit routes, not one mega-`body`.

## When stuck

Propose Domain model + sequence diagram **before** coding. Do not guess business rules.
