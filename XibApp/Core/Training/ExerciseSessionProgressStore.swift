import Foundation

struct ExerciseSetProgress: Codable, Hashable, Identifiable {
    let id: UUID
    var setNumber: Int
    var weightKg: Double
    var reps: Int
    var isCompleted: Bool

    init(
        id: UUID = UUID(),
        setNumber: Int,
        weightKg: Double,
        reps: Int,
        isCompleted: Bool
    ) {
        self.id = id
        self.setNumber = setNumber
        self.weightKg = weightKg
        self.reps = reps
        self.isCompleted = isCompleted
    }
}

struct ExerciseSessionProgress: Codable, Hashable {
    var exerciseID: String
    var exerciseSlug: String
    var selectedRestSeconds: Int
    var sets: [ExerciseSetProgress]
    var updatedAt: Date
}

@MainActor
final class ExerciseSessionProgressStore: ObservableObject {
    @Published private(set) var sessionsBySlug: [String: ExerciseSessionProgress] = [:]

    private let storageKey = "xibapp.training.exercise-session-progress.v1"

    init() {
        load()
    }

    func session(forSlug slug: String) -> ExerciseSessionProgress? {
        sessionsBySlug[normalize(slug)]
    }

    func saveSession(
        exerciseID: String,
        exerciseSlug: String,
        selectedRestSeconds: Int,
        sets: [ExerciseSetProgress],
        date: Date = Date()
    ) {
        let normalizedSlug = normalize(exerciseSlug)
        guard !normalizedSlug.isEmpty else { return }

        let clampedRestSeconds = min(max(selectedRestSeconds, 15), 600)
        let sanitizedSets = sets
            .sorted { lhs, rhs in
                if lhs.setNumber == rhs.setNumber {
                    return lhs.id.uuidString < rhs.id.uuidString
                }
                return lhs.setNumber < rhs.setNumber
            }
            .map { item in
                ExerciseSetProgress(
                    id: item.id,
                    setNumber: max(1, item.setNumber),
                    weightKg: max(0, item.weightKg),
                    reps: min(max(1, item.reps), 100),
                    isCompleted: item.isCompleted
                )
            }

        sessionsBySlug[normalizedSlug] = ExerciseSessionProgress(
            exerciseID: exerciseID,
            exerciseSlug: exerciseSlug,
            selectedRestSeconds: clampedRestSeconds,
            sets: sanitizedSets,
            updatedAt: date
        )
        save()
    }

    func clearSession(forSlug slug: String) {
        sessionsBySlug.removeValue(forKey: normalize(slug))
        save()
    }

    private func normalize(_ value: String) -> String {
        value
            .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
    }

    private func save() {
        let values = Array(sessionsBySlug.values)
        guard let data = try? JSONEncoder().encode(values) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([ExerciseSessionProgress].self, from: data) else {
            sessionsBySlug = [:]
            return
        }

        sessionsBySlug = Dictionary(uniqueKeysWithValues: decoded.map { (normalize($0.exerciseSlug), $0) })
    }
}
