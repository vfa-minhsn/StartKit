import Foundation
import RealmSwift

final class RealmExampleData: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var content: String = ""

    convenience init(id: String, content: String) {
        self.init()
        self.id = id
        self.content = content
    }

    func toDomain() -> ExampleData {
        ExampleData(id: id, content: content)
    }
}
