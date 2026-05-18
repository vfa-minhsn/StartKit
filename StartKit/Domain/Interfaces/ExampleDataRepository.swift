import Foundation

@MainActor
protocol ExampleDataRepository {
    func exampleData(id: String) async throws -> ExampleData
}
