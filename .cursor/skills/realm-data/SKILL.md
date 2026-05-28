---
name: realm-data
description: >-
  Implements Realm persistence in the Data layer: DTO objects, toDomain mapping,
  RealmProvider, repository implementations, and schema configuration. Use when
  reading/writing local data, seeding, or integrating Realm with repositories.
---

# Realm data layer

## Scope

**Only** files under `StartKit/Data/` may `import RealmSwift`.

## DTO pattern

```swift
final class RealmFoo: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var content: String = ""

    func toDomain() -> Foo {
        Foo(id: id, content: content)
    }
}
```

- Write path: map Domain → DTO inside `RepositoryImpl` before `realm.add` / `realm.write`.
- Read path: always `return dto.toDomain()` — never pass `RealmFoo` upward.

## RealmProvider

- Inject `RealmProvider` into repository implementations (constructor).
- Use dedicated Realm file URL for major schema breaks (see existing `exampledata.realm` pattern in `RealmProvider.swift`).
- Seed development data in provider only for demos—not production business rules.

## Repository implementation

```swift
@MainActor
final class FooRepositoryImpl: FooRepository {
    private let realmProvider: RealmProvider

    init(realmProvider: RealmProvider) {
        self.realmProvider = realmProvider
    }

    func foo(id: String) async throws -> Foo {
        let realm = try realmProvider.realm()
        guard let stored = realm.object(ofType: RealmFoo.self, forPrimaryKey: id) else {
            throw FooError.notFound
        }
        return stored.toDomain()
    }
}
```

## Schema changes

Use [realm-migration-versioning](../realm-migration-versioning/SKILL.md) for version bumps and migrations.

## Device builds

RealmSwift is dynamic — see [device-deployment](../device-deployment/SKILL.md) for Embed Frameworks.

## Anti-patterns

- Exposing `Realm` or `Results` from repository protocols.
- Business validation inside `realm.write` blocks (belongs in UseCase).
- Global `try! Realm()` anywhere.
