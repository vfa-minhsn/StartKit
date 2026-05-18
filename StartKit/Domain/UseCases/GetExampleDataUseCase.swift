import Foundation

@MainActor
protocol GetExampleDataUseCase {
    func execute(identifier: String) async throws -> ExampleData
}

@MainActor
final class GetExampleDataUseCaseImpl: GetExampleDataUseCase {
    private let repository: ExampleDataRepository

    init(repository: ExampleDataRepository) {
        self.repository = repository
    }

    func execute(identifier: String) async throws -> ExampleData {
        try await repository.exampleData(id: identifier)
    }
}
