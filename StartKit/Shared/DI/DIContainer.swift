import Foundation
import Observation

/// Composition root: wire dependencies via constructors; no singletons for repositories or network clients.
@Observable
@MainActor
final class DIContainer {
    let coordinator: AppCoordinator
    private let getExampleDataUseCase: GetExampleDataUseCase

    init(
        coordinator: AppCoordinator = AppCoordinator(),
        realmProvider: RealmProvider = RealmProvider(),
        exampleDataRepository: ExampleDataRepository? = nil,
        getExampleDataUseCase: GetExampleDataUseCase? = nil
    ) {
        self.coordinator = coordinator
        let repository = exampleDataRepository ?? ExampleDataRepositoryImpl(realmProvider: realmProvider)
        self.getExampleDataUseCase = getExampleDataUseCase ?? GetExampleDataUseCaseImpl(repository: repository)
    }

    func makeExampleViewModel() -> ExampleViewModel {
        ExampleViewModel(getExampleDataUseCase: getExampleDataUseCase)
    }
}
