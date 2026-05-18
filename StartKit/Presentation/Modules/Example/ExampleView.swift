import SwiftUI

struct ExampleView: View {
    @Bindable private var viewModel: ExampleViewModel
    private let coordinator: AppCoordinator

    init(viewModel: ExampleViewModel, coordinator: AppCoordinator) {
        self._viewModel = Bindable(viewModel)
        self.coordinator = coordinator
    }

    var body: some View {
        VStack(spacing: 16) {
            if viewModel.isLoading {
                ProgressView()
            }

            if let data = viewModel.exampleData {
                Text(data.content)
                    .font(.title2)
                Text(data.id)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            if let message = viewModel.errorMessage {
                Text(message)
                    .foregroundStyle(.red)
            }

            PrimaryButton(title: String(localized: "Open detail")) {
                coordinator.goToProfile()
            }
            .accessibilityIdentifier("example.openDetail")
        }
        .padding()
        .navigationTitle(String(localized: "Example"))
        .task {
            await viewModel.load(identifier: "example")
        }
    }
}
