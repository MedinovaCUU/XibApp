import Foundation

@MainActor
final class TrainingPreferencesStore: ObservableObject {
    @Published var preferences: TrainingPreferences {
        didSet { save() }
    }

    private let storageKey = "xibapp.training.preferences.v1"

    init() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode(TrainingPreferences.self, from: data) {
            self.preferences = decoded
        } else {
            self.preferences = .default
        }
    }

    func updateGoal(_ goal: TrainingGoal) {
        preferences.goal = goal
    }

    func updateSplit(_ split: TrainingSplit) {
        preferences.split = split
    }

    func updateDuration(_ minutes: Int) {
        preferences.sessionDurationMinutes = min(max(minutes, 20), 120)
    }

    func toggleEquipment(_ option: TrainingEquipmentOption) {
        if preferences.availableEquipment.contains(option) {
            if preferences.availableEquipment.count == 1 {
                return
            }
            preferences.availableEquipment.remove(option)
        } else {
            preferences.availableEquipment.insert(option)
        }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(preferences) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}

@MainActor
final class TrainingSessionHistoryStore: ObservableObject {
    @Published private(set) var sessions: [CompletedTrainingSession] = []

    private let storageKey = "xibapp.training.sessions.v1"

    init() {
        load()
    }

    func registerCompletion(for plan: SuggestedWorkoutPlan) {
        let item = CompletedTrainingSession(
            split: plan.split,
            focus: plan.focus,
            plannedMinutes: plan.estimatedMinutes,
            title: plan.title
        )
        sessions.insert(item, at: 0)
        save()
    }

    func recentSessions(limit: Int = 20) -> [CompletedTrainingSession] {
        Array(sessions.prefix(limit))
    }

    func latestFocus(for split: TrainingSplit) -> TrainingFocusArea? {
        sessions.first(where: { $0.split == split })?.focus
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(sessions) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([CompletedTrainingSession].self, from: data) else {
            sessions = []
            return
        }
        sessions = decoded.sorted { $0.date > $1.date }
    }
}
