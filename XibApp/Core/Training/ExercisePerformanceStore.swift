import Foundation

@MainActor
final class ExercisePerformanceStore: ObservableObject {
    @Published private(set) var snapshotsBySlug: [String: ExercisePerformanceSnapshot] = [:]

    private let storageKey = "xibapp.training.exercise-performance.v1"

    init() {
        load()
    }

    func registerCompletedSet(
        exerciseID: String,
        exerciseSlug: String,
        weightKg: Double,
        reps: Int,
        date: Date = Date()
    ) {
        let normalizedSlug = normalize(exerciseSlug)
        guard !normalizedSlug.isEmpty else { return }
        guard weightKg >= 0 else { return }
        guard reps > 0 else { return }

        var snapshot = snapshotsBySlug[normalizedSlug] ?? ExercisePerformanceSnapshot(
            id: normalizedSlug,
            exerciseID: exerciseID,
            exerciseSlug: exerciseSlug,
            lastWeightKg: weightKg,
            bestWeightKg: weightKg,
            lastReps: reps,
            sessionsCount: 0,
            updatedAt: date
        )

        snapshot.exerciseID = exerciseID
        snapshot.exerciseSlug = exerciseSlug
        snapshot.lastWeightKg = weightKg
        snapshot.bestWeightKg = max(snapshot.bestWeightKg, weightKg)
        snapshot.lastReps = reps
        snapshot.sessionsCount += 1
        snapshot.updatedAt = date

        snapshotsBySlug[normalizedSlug] = snapshot
        save()
    }

    func snapshot(forSlug slug: String) -> ExercisePerformanceSnapshot? {
        snapshotsBySlug[normalize(slug)]
    }

    private func normalize(_ value: String) -> String {
        value
            .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
    }

    private func save() {
        let values = Array(snapshotsBySlug.values)
        guard let data = try? JSONEncoder().encode(values) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([ExercisePerformanceSnapshot].self, from: data) else {
            snapshotsBySlug = [:]
            return
        }

        snapshotsBySlug = Dictionary(uniqueKeysWithValues: decoded.map { (normalize($0.exerciseSlug), $0) })
    }
}
