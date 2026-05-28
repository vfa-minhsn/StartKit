---
name: legacy-parity
description: >-
  Verifies iPhone app behavior matches the legacy Windows tablet measurement
  system using parity checklists and test cases. Use during UAT, migration
  sprints, or when validating ported VB.NET functionality.
---

# Legacy parity

## Parity checklist (per feature)

```markdown
## Feature: [name]
- [ ] Legacy screen/module ID documented
- [ ] All input fields mapped to Domain model
- [ ] Validations match legacy (list each rule)
- [ ] Error messages equivalent (English in new app)
- [ ] Happy path outcome matches (data saved / sent)
- [ ] Edge cases from legacy tested (empty, max, offline if applicable)
- [ ] Unit tests cover each rule ID
- [ ] UI test or manual script for critical path
```

## Test levels

| Level | Tool |
|-------|------|
| Business rules | XCTest on UseCases |
| UI state | ViewModel XCTest |
| Full flow | XCUITest or manual UAT script |

## Documenting differences

If intentional change from legacy:

```markdown
### DELTA-001
- **Legacy**: ...
- **New**: ...
- **Approved by**: [name/date]
```

## Data migration

If users need existing tablet data on iPhone, define separate **import/migration** story — not automatic in feature slices.

## Sign-off

Parity is **not** “compiles on device.” Require checked rules + tests linked in PR description.
