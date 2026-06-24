import SwiftUI

private enum AppRoute: Hashable {
    case exerciseDetail(slug: String)
}

@main
struct XibAppApp: App {
    @StateObject private var accountSession = AccountSessionStore()
    @StateObject private var eventRegistrationStore = EventRegistrationStore()
    @StateObject private var trainingPreferencesStore = TrainingPreferencesStore()
    @StateObject private var trainingSessionHistoryStore = TrainingSessionHistoryStore()
    @StateObject private var exercisePerformanceStore = ExercisePerformanceStore()
    @StateObject private var exerciseSessionProgressStore = ExerciseSessionProgressStore()
    @StateObject private var activeRestTimerStore = ActiveRestTimerStore()
    @State private var appPath = NavigationPath()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appPath) {
                Group {
                    if accountSession.hasAccount {
                        HomeView()
                    } else {
                        AccountRegistrationView(mode: .onboarding)
                    }
                }
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .exerciseDetail(let slug):
                        ExerciseDetailScreen(slug: slug)
                    }
                }
            }
            .safeAreaInset(edge: .top, spacing: 4) {
                GlobalRestTimerBanner(onOpenActiveExercise: openActiveExerciseFromBanner)
            }
            .environmentObject(accountSession)
            .environmentObject(eventRegistrationStore)
            .environmentObject(trainingPreferencesStore)
            .environmentObject(trainingSessionHistoryStore)
            .environmentObject(exercisePerformanceStore)
            .environmentObject(exerciseSessionProgressStore)
            .environmentObject(activeRestTimerStore)
            .preferredColorScheme(.dark)
        }
    }

    private func openActiveExerciseFromBanner() {
        guard accountSession.hasAccount,
              let slug = activeRestTimerStore.exerciseSlug?.trimmingCharacters(in: .whitespacesAndNewlines),
              !slug.isEmpty
        else { return }

        appPath.append(AppRoute.exerciseDetail(slug: slug))
    }
}
