---
name: measurement-domain
description: >-
  Documents and applies measurement-business domain terms, entities, and rules
  for the iPhone app replacing the Windows tablet system. Use when implementing
  features, naming types, or clarifying legacy VB.NET behavior.
---

# Measurement domain

**Living document** — extend this skill as specs are confirmed.

## Purpose

- Shared vocabulary for agents and developers.
- Consistent naming in Domain layer.
- Traceability to legacy system modules.

## Naming conventions

> Avoid Swift reserved/overloaded identifiers (`Operator`, `Type`, `Protocol`, `Any`).
> Suffix domain meaning when the bare word is ambiguous (e.g. `InspectorAccount` instead of `Operator`).

| Concept | Swift entity (example) | Notes |
|---------|------------------------|-------|
| Example placeholder | `ExampleData` | Starter template only |
| *(add)* Work order | `WorkOrder` | |
| *(add)* Measurement session | `MeasurementSession` | |
| *(add)* Instrument / device | `Instrument` | |
| *(add)* Inspector (user / operator) | `Inspector` | Avoid Swift keyword `Operator` |

## Rules placeholder

Document each rule as:

```markdown
### RULE-001: [Short title]
- **Legacy ref**: [VB form/module name if known]
- **Trigger**: When ...
- **Validation**: ...
- **Outcome**: ...
- **UseCase**: `XxxUseCase`
```

## How to update this file

When product owner or legacy spec clarifies behavior:

1. Add term to table above.
2. Add RULE-xxx entry.
3. Link new UseCase name in [feature-slice](../feature-slice/SKILL.md) checklist.

## Agent instructions

- Before inventing field names, check this file.
- If domain is unclear, **ask** or mark `// TODO: domain confirm` and list open questions in PR — do not guess critical measurement rules.

## Related

- [vbnet-migration](../vbnet-migration/SKILL.md)
- [legacy-parity](../legacy-parity/SKILL.md)
- [domain-usecase](../domain-usecase/SKILL.md)
