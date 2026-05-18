import Foundation
@testable import StartKit

@MainActor
final class MockGetExampleDataUseCase: GetExampleDataUseCase {
    enum Outcome {
        case success(ExampleData)
        case failure(Error)
    }

    private let outcome: Outcome
    private(set) var receivedIdentifiers: [String] = []

    init(outcome: Outcome) {
        self.outcome = outcome
    }

    convenience init(data: ExampleData) {
        self.init(outcome: .success(data))
    }

    convenience init(error: Error) {
        self.init(outcome: .failure(error))
    }

    func execute(identifier: String) async throws -> ExampleData {
        receivedIdentifiers.append(identifier)
        switch outcome {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}
