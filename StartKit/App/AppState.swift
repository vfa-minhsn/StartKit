import Observation

@Observable
@MainActor
final class AppState {
    var isReady = true
}
