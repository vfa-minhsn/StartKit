import SnapshotTesting
import SwiftUI
import UIKit
import XCTest
@testable import StartKit

final class ExampleViewSnapshotTests: XCTestCase {
    @MainActor
    func testExampleView_loadedState() async throws {
        let data = ExampleData(id: "example", content: "ExampleData")
        let mock = MockGetExampleDataUseCase(data: data)
        let viewModel = ExampleViewModel(getExampleDataUseCase: mock)
        await viewModel.load(identifier: "example")

        let coordinator = AppCoordinator()
        let view = NavigationStack {
            ExampleView(viewModel: viewModel, coordinator: coordinator)
        }

        let hosting = UIHostingController(rootView: view)
        hosting.view.bounds = CGRect(x: 0, y: 0, width: 390, height: 844)
        hosting.view.backgroundColor = .systemBackground
        hosting.view.layoutIfNeeded()

        try await Task.sleep(for: .milliseconds(200))

        assertSnapshot(
            of: hosting,
            as: .image(precision: 0.96, perceptualPrecision: 0.98),
            named: "default",
            record: .never
        )
    }
}
