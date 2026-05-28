---
name: code-review
description: >-
  Reviews iOS measurement app changes against MVVM, UseCase, Repository, and
  Realm layer rules, test coverage, and VB.NET migration anti-patterns. Use
  when reviewing pull requests, diffs, or before merging feature work.
---

# Code review

## Blockers (must fix)

- [ ] `import RealmSwift` outside `Data/`
- [ ] Business logic in SwiftUI `View`
- [ ] ViewModel uses repository or Realm directly
- [ ] Domain entity exposes Realm types
- [ ] New feature without ViewModel (or UseCase) unit tests
- [ ] Objective-C added

## Major

- [ ] UseCase bypassed (ViewModel → Repository)
- [ ] Singleton for data/network access
- [ ] Deep nesting (>3 levels) without refactor
- [ ] God class / file >300 lines without split plan
- [ ] Missing `DIContainer` wiring for new feature
- [ ] UI strings not in English

## Minor

- [ ] Missing `accessibilityIdentifier` for UI-tested controls
- [ ] Inconsistent naming vs [feature-slice](../feature-slice/SKILL.md)
- [ ] Snapshot not updated when UI intentionally changed

## Architecture scan

```bash
rg "import RealmSwift" StartKit --glob "*.swift" | rg -v "/Data/"
```

## Feedback format

- **Blocker**: must fix before merge
- **Major**: should fix
- **Minor**: optional

## Migration review

If PR ports legacy behavior, verify against [legacy-parity](../legacy-parity/SKILL.md) and [vbnet-migration](../vbnet-migration/SKILL.md).
