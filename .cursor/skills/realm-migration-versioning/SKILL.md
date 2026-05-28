---
name: realm-migration-versioning
description: >-
  Manages Realm schema versions and migrations for the measurement app when
  entities or fields change across releases. Use when altering Realm DTOs,
  bumping schemaVersion, or migrating user data on upgrade.
---

# Realm migration & versioning

## When to bump version

- Add/remove/rename persisted properties
- Change primary key strategy
- Split or merge object types

## Configuration

```swift
Realm.Configuration(
    fileURL: realmFileURL(),
    schemaVersion: 3,
    migrationBlock: { migration, oldSchemaVersion in
        if oldSchemaVersion < 2 {
            // migrate 1 → 2
        }
        if oldSchemaVersion < 3 {
            // migrate 2 → 3
        }
    }
)
```

## Practices

- Increment `schemaVersion` monotonically.
- Keep migration blocks **idempotent** per version step.
- Prefer new Realm file URL for breaking renames during early development (see `RealmProvider` `exampledata.realm` pattern).
- Delete obsolete legacy object types in migration when retiring VB-era models.

## Testing migrations

1. Save fixture Realm file at version N (or document manual steps).
2. Launch app with version N+1 config in test target if needed.
3. Assert `toDomain()` output for sample objects.

## Coordination

- Document version in PR: “Schema 2 → 3: added field X”.
- Update [measurement-domain](../measurement-domain/SKILL.md) if business meaning changes.

## Do not

- Ship destructive migration without backup story for production users.
- Run heavy migration on main thread for large datasets — consider background + progress UI.
