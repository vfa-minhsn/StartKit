import Foundation
import Observation

@Observable
@MainActor
final class ExampleViewModel {
    private let getExampleDataUseCase: GetExampleDataUseCase

    private(set) var exampleData: ExampleData?
    private(set) var errorMessage: String?
    private(set) var isLoading = false

    init(getExampleDataUseCase: GetExampleDataUseCase) {
        self.getExampleDataUseCase = getExampleDataUseCase
    }

    func load(identifier: String) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            exampleData = try await getExampleDataUseCase.execute(identifier: identifier)
        } catch {
            exampleData = nil
            errorMessage = String(localized: "Could not load example data.")
        }
    }
}
