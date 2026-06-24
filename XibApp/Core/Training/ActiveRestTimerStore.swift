import Foundation
import SwiftUI

struct RestTimerGuidance: Equatable {
    var headline: String
    var subtitle: String
    var nextExerciseName: String?
    var nextExerciseMeta: String?
    var showsTransientNextExercise: Bool
}

@MainActor
final class ActiveRestTimerStore: ObservableObject {
    @Published private(set) var remainingSeconds: Int = 0
    @Published private(set) var totalSeconds: Int = 0
    @Published private(set) var activeSetID: UUID?
    @Published private(set) var activeSetNumber: Int?
    @Published private(set) var exerciseSlug: String?
    @Published private(set) var exerciseName: String?
    @Published private(set) var guidance: RestTimerGuidance = .init(
        headline: "Descanso en curso",
        subtitle: "Prepárate para tu siguiente serie.",
        nextExerciseName: nil,
        nextExerciseMeta: nil,
        showsTransientNextExercise: false
    )
    @Published var isBannerCollapsed: Bool = false
    @Published var isTransientNextExerciseVisible: Bool = false

    var isRunning: Bool {
        remainingSeconds > 0
    }

    private var timerTask: Task<Void, Never>?
    private var transientTask: Task<Void, Never>?

    deinit {
        timerTask?.cancel()
        transientTask?.cancel()
    }

    func start(
        durationSeconds: Int,
        setID: UUID?,
        setNumber: Int?,
        exerciseSlug: String?,
        exerciseName: String?,
        guidance: RestTimerGuidance
    ) {
        timerTask?.cancel()

        totalSeconds = max(1, durationSeconds)
        remainingSeconds = max(1, durationSeconds)
        activeSetID = setID
        activeSetNumber = setNumber
        self.exerciseSlug = exerciseSlug
        self.exerciseName = exerciseName
        self.guidance = guidance

        beginTransientHintIfNeeded()

        timerTask = Task { [weak self] in
            guard let self else { return }

            while remainingSeconds > 0 {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                if Task.isCancelled { return }
                remainingSeconds -= 1
            }

            completeTimer()
        }
    }

    func restart() {
        guard totalSeconds > 0 else { return }
        start(
            durationSeconds: totalSeconds,
            setID: activeSetID,
            setNumber: activeSetNumber,
            exerciseSlug: exerciseSlug,
            exerciseName: exerciseName,
            guidance: guidance
        )
    }

    func skip() {
        timerTask?.cancel()
        completeTimer()
    }

    private func beginTransientHintIfNeeded() {
        transientTask?.cancel()
        isTransientNextExerciseVisible = false

        guard guidance.showsTransientNextExercise,
              guidance.nextExerciseName != nil
        else { return }

        isTransientNextExerciseVisible = true
        transientTask = Task { [weak self] in
            guard let self else { return }
            try? await Task.sleep(nanoseconds: 2_200_000_000)
            if Task.isCancelled { return }
            withAnimation(.easeInOut(duration: 0.35)) {
                isTransientNextExerciseVisible = false
            }
        }
    }

    private func completeTimer() {
        transientTask?.cancel()
        transientTask = nil
        remainingSeconds = 0
        isTransientNextExerciseVisible = false
        activeSetID = nil
        activeSetNumber = nil
    }
}
