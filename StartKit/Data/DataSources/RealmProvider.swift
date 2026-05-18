import Foundation
import RealmSwift

@MainActor
final class RealmProvider {
    private let configuration: Realm.Configuration

    init(configuration: Realm.Configuration = RealmProvider.makeDefaultConfiguration()) {
        self.configuration = configuration
        seedExampleDataIfNeeded()
    }

    func realm() throws -> Realm {
        try Realm(configuration: configuration)
    }

    private func seedExampleDataIfNeeded() {
        do {
            let realm = try Realm(configuration: configuration)
            guard realm.objects(RealmExampleData.self).isEmpty else { return }
            try realm.write {
                realm.add(RealmExampleData(id: "example", content: "ExampleData"))
            }
        } catch {
            assertionFailure("RealmProvider seed failed: \(error)")
        }
    }

    /// Dedicated Realm file for the example flow to avoid migrating legacy starter schemas (e.g. old RealmUser types).
    private static func makeDefaultConfiguration() -> Realm.Configuration {
        Realm.Configuration(
            fileURL: realmFileURL(),
            schemaVersion: 1,
            migrationBlock: { _, _ in }
        )
    }

    private static func realmFileURL() -> URL {
        let base = try? FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        let folder = (base ?? FileManager.default.temporaryDirectory)
            .appendingPathComponent("StartKit", isDirectory: true)
        try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        return folder.appendingPathComponent("exampledata.realm")
    }
}
