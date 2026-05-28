---
name: network-sync
description: >-
  Implements async HTTP networking and sync patterns via NetworkClient and
  repositories for the measurement iOS app, keeping API details out of Domain
  and Presentation. Use when adding REST APIs, upload/download, or offline-first sync.
---

# Network sync

## Placement

| Piece | Layer |
|-------|--------|
| `NetworkClient` (URLSession) | `Data/DataSources/` |
| API DTOs / decoding | `Data/` (map to Domain before return) |
| Sync orchestration | Domain UseCase |
| Retry/backoff policy | UseCase or dedicated `SyncService` in Data |

## Rules

- **No** `URLSession` in ViewModel or View.
- Repository protocol in **Domain**; implementation may call network + Realm.
- Network failures → domain errors, not raw `URLError` in Presentation.
- Retry/backoff with **async `Task.sleep(for:)`** — never block the calling actor with `Thread.sleep`.

## NetworkClient (existing stub)

```swift
struct NetworkClient: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
```

Inject via `DIContainer` when features need it — no singleton.

## Offline-first pattern

1. UseCase writes to Realm via repository (local source of truth).
2. Background sync UseCase pushes/pulls when network available.
3. Expose sync state on ViewModel (`isSyncing`, `lastSyncDate`).

## Testing

- Mock repository returning canned `Data` / entities.
- Use `URLProtocol` stub or inject `NetworkClient` with a test `URLSession` for integration tests.

## Security

- No secrets in source — use Keychain / xcconfig excluded from git.
- HTTPS only unless spec requires otherwise.
