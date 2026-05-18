import SwiftUI

struct RootView: View {
    @Environment(DIContainer.self) private var container

    var body: some View {
        @Bindable var coordinator = container.coordinator

        NavigationStack(path: $coordinator.path) {
            ExampleView(
                viewModel: container.makeExampleViewModel(),
                coordinator: container.coordinator
            )
            .navigationDestination(for: AppCoordinator.Route.self) { route in
                switch route {
                case .profile:
                    ProfileView()
                }
            }
        }
    }
}
