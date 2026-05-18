import Foundation
import RealmSwift

@MainActor
final class ExampleDataRepositoryImpl: ExampleDataRepository {
    private let realmProvider: RealmProvider

    init(realmProvider: RealmProvider) {
        self.realmProvider = realmProvider
    }

    func exampleData(id: String) async throws -> ExampleData {
        let realm = try realmProvider.realm()
        guard let stored = realm.object(ofType: RealmExampleData.self, forPrimaryKey: id) else {
            throw ExampleDataError.notFound
        }
        return stored.toDomain()
    }
}
