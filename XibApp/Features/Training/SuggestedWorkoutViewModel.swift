import Foundation

@MainActor
final class SuggestedWorkoutViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded(SuggestedWorkoutPlan)
        case failed(String)
    }

    @Published private(set) var state: State = .idle

    var currentPlan: SuggestedWorkoutPlan? {
        if case .loaded(let plan) = state {
            return plan
        }
        return nil
    }

    private let repository: ExerciseRepositoryType
    private var loadTask: Task<Void, Never>?
    private var lastKey: String?

    init(repository: ExerciseRepositoryType = ExerciseRepository()) {
        self.repository = repository
    }

    deinit {
        loadTask?.cancel()
    }

    func loadIfNeeded(
        preferences: TrainingPreferences,
        history: [CompletedTrainingSession],
        performanceBySlug: [String: ExercisePerformanceSnapshot]
    ) {
        let key = makeKey(
            preferences: preferences,
            history: history,
            performanceBySlug: performanceBySlug
        )
        guard key != lastKey else { return }
        load(
            preferences: preferences,
            history: history,
            performanceBySlug: performanceBySlug,
            force: false
        )
    }

    func retry(
        preferences: TrainingPreferences,
        history: [CompletedTrainingSession],
        performanceBySlug: [String: ExercisePerformanceSnapshot]
    ) {
        load(
            preferences: preferences,
            history: history,
            performanceBySlug: performanceBySlug,
            force: true
        )
    }

    func load(
        preferences: TrainingPreferences,
        history: [CompletedTrainingSession],
        performanceBySlug: [String: ExercisePerformanceSnapshot],
        force: Bool
    ) {
        let key = makeKey(
            preferences: preferences,
            history: history,
            performanceBySlug: performanceBySlug
        )
        if !force, key == lastKey, case .loaded = state {
            return
        }

        lastKey = key
        loadTask?.cancel()
        state = .loading

        loadTask = Task { [weak self] in
            guard let self else { return }

            do {
                let catalog = try await repository.fetchCatalog(searchText: "")
                if Task.isCancelled { return }

                let plan = TrainingRecommendationEngine.makePlan(
                    preferences: preferences,
                    history: history,
                    catalog: catalog,
                    performanceBySlug: performanceBySlug
                )

                state = .loaded(plan)
            } catch {
                if Task.isCancelled { return }
                state = .failed(error.localizedDescription)
            }
        }
    }

    private func makeKey(
        preferences: TrainingPreferences,
        history: [CompletedTrainingSession],
        performanceBySlug: [String: ExercisePerformanceSnapshot]
    ) -> String {
        let historyKey = history
            .prefix(6)
            .map { "\($0.date.timeIntervalSince1970)-\($0.split.rawValue)-\($0.focus.rawValue)" }
            .joined(separator: "|")

        let performanceKey = performanceBySlug
            .values
            .sorted { $0.updatedAt > $1.updatedAt }
            .prefix(12)
            .map { "\($0.exerciseSlug)-\($0.updatedAt.timeIntervalSince1970)-\($0.lastWeightKg)-\($0.lastReps)" }
            .joined(separator: "|")

        return "\(preferences.refreshKey)#\(history.count)#\(historyKey)#\(performanceBySlug.count)#\(performanceKey)"
    }
}
