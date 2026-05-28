---
name: localization
description: >-
  Applies English UI copy and String localization conventions for the
  measurement iPhone app. Use when adding labels, buttons, errors, or
  navigation titles in SwiftUI.
---

# Localization

## Policy

- **Production UI copy: English** (project standard).
- Use `String(localized: "…")` for user-visible strings in Views and ViewModels.

## Examples

```swift
.navigationTitle(String(localized: "Example"))
errorMessage = String(localized: "Could not load example data.")
PrimaryButton(title: String(localized: "Open detail")) { ... }
```

## XCUITest

- Prefer `accessibilityIdentifier` for queries — see [ui-test-xcuitest](../ui-test-xcuitest/SKILL.md).
- If testing visible text, use English strings consistent with localization keys.

## Future multi-language

If Japanese or other locales are required later:

1. Add `Localizable.xcstrings` (or legacy strings files).
2. Keep keys stable; translate values per locale.
3. Update this skill with supported locales.

## Do not

- Ship Vietnamese or Japanese UI strings unless product explicitly requests locale support.
- Hardcode concatenated sentences without localization wrapper for user-visible text.
