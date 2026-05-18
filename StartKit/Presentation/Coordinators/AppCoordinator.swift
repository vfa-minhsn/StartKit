import SwiftUI

@Observable
@MainActor
final class AppCoordinator {
    enum Route: Hashable {
        case profile
    }

    var path = NavigationPath()

    func goToProfile() {
        path.append(Route.profile)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
