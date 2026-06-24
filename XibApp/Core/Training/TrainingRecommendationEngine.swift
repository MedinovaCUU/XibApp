import Foundation

private enum WorkoutIntensity {
    case heavy
    case moderate
    case light

    var baseRestSeconds: Int {
        switch self {
        case .heavy: return 180
        case .moderate: return 90
        case .light: return 30
        }
    }
}

private struct WorkoutBlockBlueprint {
    var type: WorkoutBlockType
    var size: Int
    var rounds: Int?
    var restBetweenRounds: Int?
}

private struct MusclePriorityProfile {
    let primary: [String]
    let secondary: [String]
}

private struct ProgressionPlan {
    let suggestedWeightKg: Double?
    let note: String
}

struct TrainingRecommendationEngine {
    static func makePlan(
        preferences: TrainingPreferences,
        history: [CompletedTrainingSession],
        catalog: [ExerciseCatalogItemDTO],
        performanceBySlug: [String: ExercisePerformanceSnapshot] = [:],
        generatedAt: Date = Date()
    ) -> SuggestedWorkoutPlan {
        let focus = nextFocus(for: preferences.split, history: history, now: generatedAt)
        let focusFatigue = fatiguePenalty(
            for: focus,
            split: preferences.split,
            history: history,
            now: generatedAt
        )

        let adjustedDuration = max(20, preferences.sessionDurationMinutes - Int((focusFatigue * 6).rounded()))

        let equipmentFiltered = filterByEquipment(catalog, equipment: preferences.availableEquipment)
        let focusFiltered = filterByFocus(equipmentFiltered, focus: focus)

        let basePool: [ExerciseCatalogItemDTO]
        if !focusFiltered.isEmpty {
            basePool = focusFiltered
        } else {
            basePool = equipmentFiltered
        }

        let rawTargetCount = targetExerciseCount(durationMinutes: adjustedDuration)
        let fatigueReduction = Int(floor(max(0, focusFatigue - 1.2)))
        let targetCount = max(2, rawTargetCount - fatigueReduction)

        let blueprints = makeBlueprints(
            goal: preferences.goal,
            durationMinutes: adjustedDuration,
            targetCount: targetCount,
            fatiguePenalty: focusFatigue
        )

        let scoredPool = basePool.sorted {
            score(
                $0,
                focus: focus,
                goal: preferences.goal,
                fatiguePenalty: focusFatigue
            ) > score(
                $1,
                focus: focus,
                goal: preferences.goal,
                fatiguePenalty: focusFatigue
            )
        }

        var usedIds = Set<String>()
        var blocks: [WorkoutPlanBlock] = []
        var blockIndex = 1

        for blueprint in blueprints {
            let picks = pickExercises(
                from: scoredPool,
                type: blueprint.type,
                goal: preferences.goal,
                requestedCount: blueprint.size,
                usedIds: &usedIds
            )

            guard !picks.isEmpty else { continue }

            let exercises = picks.enumerated().map { offset, item -> WorkoutExercisePrescription in
                let intensity = inferIntensity(for: item)
                let basePrescription = makePrescription(
                    goal: preferences.goal,
                    blockType: blueprint.type,
                    intensity: intensity,
                    focus: focus
                )

                let progression = makeProgression(
                    for: item,
                    snapshot: performanceSnapshot(for: item, performanceBySlug: performanceBySlug),
                    repsText: basePrescription.repsText,
                    goal: preferences.goal,
                    intensity: intensity
                )

                let restSeconds = adjustRest(
                    base: basePrescription.restSeconds,
                    fatiguePenalty: focusFatigue,
                    blockType: blueprint.type
                )

                return WorkoutExercisePrescription(
                    id: "\(item.id)-\(blockIndex)-\(offset)",
                    exercise: item,
                    sets: basePrescription.sets,
                    repsText: basePrescription.repsText,
                    restSeconds: restSeconds,
                    notes: basePrescription.notes,
                    suggestedWeightKg: progression.suggestedWeightKg,
                    progressionNote: progression.note
                )
            }

            let title = blockTitle(type: blueprint.type, index: blockIndex, goal: preferences.goal)
            let subtitle = blockSubtitle(type: blueprint.type, rounds: blueprint.rounds)

            blocks.append(
                WorkoutPlanBlock(
                    type: blueprint.type,
                    title: title,
                    subtitle: subtitle,
                    exercises: exercises,
                    rounds: blueprint.rounds,
                    restBetweenRounds: blueprint.restBetweenRounds
                )
            )

            blockIndex += 1
        }

        let estimatedMinutes = estimateDurationMinutes(
            fallbackDuration: adjustedDuration,
            blocks: blocks
        )

        let hasMatches = !blocks.isEmpty
        let computedRationale = rationale(
            goal: preferences.goal,
            split: preferences.split,
            focus: focus,
            durationMinutes: adjustedDuration,
            equipmentCount: preferences.availableEquipment.count,
            fatiguePenalty: focusFatigue
        ) + (hasMatches ? "" : " No se encontraron ejercicios compatibles con el equipo seleccionado; ajusta tus preferencias de equipo.")

        return SuggestedWorkoutPlan(
            generatedAt: generatedAt,
            goal: preferences.goal,
            split: preferences.split,
            focus: focus,
            title: hasMatches ? "Entrenamiento sugerido: \(focus.rawValue)" : "Sin coincidencias de equipo",
            subtitle: "\(preferences.goal.rawValue) • \(estimatedMinutes) min",
            estimatedMinutes: estimatedMinutes,
            rationale: computedRationale,
            blocks: blocks
        )
    }

    static func nextFocus(
        for split: TrainingSplit,
        history: [CompletedTrainingSession],
        now: Date = Date()
    ) -> TrainingFocusArea {
        let cycle = cycleForSplit(split)
        guard !cycle.isEmpty else { return .fullBody }

        let splitHistory = history
            .filter { $0.split == split }
            .sorted { $0.date > $1.date }

        guard let last = splitHistory.first,
              let lastIndex = cycle.firstIndex(of: last.focus)
        else {
            return cycle[0]
        }

        let orderedCandidates: [(focus: TrainingFocusArea, order: Int)] = (0..<cycle.count).map { step in
            let index = (lastIndex + 1 + step) % cycle.count
            return (focus: cycle[index], order: step)
        }

        let selected = orderedCandidates.min { left, right in
            let leftPenalty = fatiguePenalty(for: left.focus, split: split, history: history, now: now) + Double(left.order) * 0.55
            let rightPenalty = fatiguePenalty(for: right.focus, split: split, history: history, now: now) + Double(right.order) * 0.55
            return leftPenalty < rightPenalty
        }

        return selected?.focus ?? cycle[(lastIndex + 1) % cycle.count]
    }

    static func cycleForSplit(_ split: TrainingSplit) -> [TrainingFocusArea] {
        switch split {
        case .pushPullLegs:
            return [.push, .pull, .legs]
        case .upperLowerFullBody:
            return [.upper, .lower, .fullBody]
        case .fullBody:
            return [.fullBody]
        case .upperLower:
            return [.upper, .lower]
        }
    }

    private static func fatiguePenalty(
        for focus: TrainingFocusArea,
        split: TrainingSplit,
        history: [CompletedTrainingSession],
        now: Date
    ) -> Double {
        let focusSessions = history
            .filter { $0.split == split && $0.focus == focus }
            .sorted { $0.date > $1.date }

        guard let latest = focusSessions.first else {
            return 0
        }

        let elapsed = max(0, now.timeIntervalSince(latest.date))
        let hours = elapsed / 3600

        let recencyPenalty: Double
        switch hours {
        case ..<24: recencyPenalty = 2.6
        case 24..<48: recencyPenalty = 1.5
        case 48..<72: recencyPenalty = 0.8
        case 72..<120: recencyPenalty = 0.35
        default: recencyPenalty = 0
        }

        let weeklyWindow = now.addingTimeInterval(-7 * 24 * 3600)
        let weeklyCount = focusSessions.filter { $0.date >= weeklyWindow }.count
        let loadPenalty = Double(max(0, weeklyCount - 1)) * 0.22

        return recencyPenalty + loadPenalty
    }

    private static func targetExerciseCount(durationMinutes: Int) -> Int {
        switch durationMinutes {
        case ..<35: return 3
        case 35..<50: return 4
        case 50..<65: return 5
        case 65..<80: return 6
        default: return 7
        }
    }

    private static func makeBlueprints(
        goal: TrainingGoal,
        durationMinutes: Int,
        targetCount: Int,
        fatiguePenalty: Double
    ) -> [WorkoutBlockBlueprint] {
        let template: [WorkoutBlockType]
        switch goal {
        case .gainStrength:
            template = [.single, .single, .single, .superset]
        case .gainMuscle:
            template = [.single, .superset, .single]
        case .defineMuscle:
            template = [.superset, .circuit, .single]
        case .loseFat:
            template = [.circuit, .superset, .circuit]
        case .improveConditioning:
            template = [.circuit, .circuit, .superset]
        }

        var pending = max(2, targetCount)
        var index = 0
        var result: [WorkoutBlockBlueprint] = []

        while pending > 0 {
            var type = template[index % template.count]
            var blockSize = defaultBlockSize(type)

            if pending < blockSize {
                if pending == 1 {
                    type = .single
                    blockSize = 1
                } else {
                    blockSize = pending
                }
            }

            let rounds: Int?
            let restBetweenRounds: Int?
            switch type {
            case .single:
                rounds = nil
                restBetweenRounds = nil
            case .superset:
                let baseRounds = durationMinutes >= 60 ? 4 : 3
                rounds = fatiguePenalty >= 2.0 ? max(2, baseRounds - 1) : baseRounds
                restBetweenRounds = goal == .gainStrength ? 90 : 60
            case .circuit:
                let baseRounds: Int
                if goal == .improveConditioning && durationMinutes >= 60 {
                    baseRounds = 5
                } else {
                    baseRounds = durationMinutes >= 50 ? 4 : 3
                }
                rounds = fatiguePenalty >= 2.0 ? max(2, baseRounds - 1) : baseRounds
                restBetweenRounds = goal == .gainStrength ? 90 : 60
            }

            result.append(
                WorkoutBlockBlueprint(
                    type: type,
                    size: blockSize,
                    rounds: rounds,
                    restBetweenRounds: restBetweenRounds
                )
            )

            pending -= blockSize
            index += 1
        }

        return result
    }

    private static func defaultBlockSize(_ type: WorkoutBlockType) -> Int {
        switch type {
        case .single: return 1
        case .superset: return 2
        case .circuit: return 3
        }
    }

    private static func pickExercises(
        from pool: [ExerciseCatalogItemDTO],
        type: WorkoutBlockType,
        goal: TrainingGoal,
        requestedCount: Int,
        usedIds: inout Set<String>
    ) -> [ExerciseCatalogItemDTO] {
        let preferredIntensities = preferredIntensitiesForBlock(type: type, goal: goal)
        let buckets = Dictionary(grouping: pool, by: inferIntensity)

        var result: [ExerciseCatalogItemDTO] = []

        for intensity in preferredIntensities {
            guard let items = buckets[intensity] else { continue }
            for item in items where !usedIds.contains(item.id) {
                result.append(item)
                usedIds.insert(item.id)
                if result.count >= requestedCount {
                    return result
                }
            }
        }

        if result.count < requestedCount {
            for item in pool where !usedIds.contains(item.id) {
                result.append(item)
                usedIds.insert(item.id)
                if result.count >= requestedCount {
                    break
                }
            }
        }

        return result
    }

    private static func preferredIntensitiesForBlock(type: WorkoutBlockType, goal: TrainingGoal) -> [WorkoutIntensity] {
        switch (goal, type) {
        case (.gainStrength, .single): return [.heavy, .moderate, .light]
        case (.gainStrength, .superset): return [.moderate, .light, .heavy]
        case (.gainStrength, .circuit): return [.moderate, .light, .heavy]

        case (.gainMuscle, .single): return [.heavy, .moderate, .light]
        case (.gainMuscle, .superset): return [.moderate, .light, .heavy]
        case (.gainMuscle, .circuit): return [.light, .moderate, .heavy]

        case (.defineMuscle, .single): return [.moderate, .light, .heavy]
        case (.defineMuscle, .superset): return [.moderate, .light, .heavy]
        case (.defineMuscle, .circuit): return [.light, .moderate, .heavy]

        case (.loseFat, .single): return [.moderate, .light, .heavy]
        case (.loseFat, .superset): return [.light, .moderate, .heavy]
        case (.loseFat, .circuit): return [.light, .moderate, .heavy]

        case (.improveConditioning, .single): return [.light, .moderate, .heavy]
        case (.improveConditioning, .superset): return [.light, .moderate, .heavy]
        case (.improveConditioning, .circuit): return [.light, .moderate, .heavy]
        }
    }

    private struct Prescription {
        var sets: Int
        var repsText: String
        var restSeconds: Int
        var notes: String
    }

    private static func makePrescription(
        goal: TrainingGoal,
        blockType: WorkoutBlockType,
        intensity: WorkoutIntensity,
        focus: TrainingFocusArea
    ) -> Prescription {
        switch goal {
        case .gainStrength:
            switch intensity {
            case .heavy:
                return Prescription(sets: blockType == .single ? 4 : 3, repsText: "4-6 reps", restSeconds: intensity.baseRestSeconds, notes: "Carga alta con técnica estricta.")
            case .moderate:
                return Prescription(sets: 3, repsText: "6-8 reps", restSeconds: 120, notes: "Controla la fase excéntrica.")
            case .light:
                return Prescription(sets: 3, repsText: "10-12 reps", restSeconds: 45, notes: "Usa este bloque como accesorio.")
            }

        case .gainMuscle:
            switch intensity {
            case .heavy:
                return Prescription(sets: 4, repsText: "6-8 reps", restSeconds: 150, notes: "Enfócate en tensión mecánica.")
            case .moderate:
                return Prescription(sets: 3, repsText: "8-12 reps", restSeconds: intensity.baseRestSeconds, notes: "Busca rango completo y control.")
            case .light:
                return Prescription(sets: 3, repsText: "12-15 reps", restSeconds: 45, notes: "Serie metabólica para cierre.")
            }

        case .defineMuscle:
            switch intensity {
            case .heavy:
                return Prescription(sets: 3, repsText: "6-8 reps", restSeconds: 120, notes: "Mantén calidad de repeticiones.")
            case .moderate:
                return Prescription(sets: 3, repsText: "10-14 reps", restSeconds: blockType == .single ? 60 : 45, notes: "Prioriza densidad de entrenamiento.")
            case .light:
                return Prescription(sets: 3, repsText: "12-18 reps", restSeconds: intensity.baseRestSeconds, notes: "Descansos cortos para mayor gasto energético.")
            }

        case .loseFat:
            switch intensity {
            case .heavy:
                return Prescription(sets: 3, repsText: "6-8 reps", restSeconds: 120, notes: "Conserva fuerza base.")
            case .moderate:
                return Prescription(sets: 3, repsText: "10-15 reps", restSeconds: 45, notes: "Mantén ritmo continuo.")
            case .light:
                return Prescription(sets: 3, repsText: "12-20 reps", restSeconds: intensity.baseRestSeconds, notes: "Bloque metabólico.")
            }

        case .improveConditioning:
            switch intensity {
            case .heavy:
                return Prescription(sets: 3, repsText: "6-8 reps", restSeconds: 120, notes: "Compuesto de soporte.")
            case .moderate:
                return Prescription(sets: 3, repsText: "10-14 reps", restSeconds: 45, notes: "Transiciones rápidas.")
            case .light:
                let note = focus == .fullBody
                    ? "Prioriza respiración y ritmo constante."
                    : "Enfoca cardio y control técnico."
                return Prescription(sets: 3, repsText: "40 seg trabajo", restSeconds: intensity.baseRestSeconds, notes: note)
            }
        }
    }

    private static func adjustRest(
        base: Int,
        fatiguePenalty: Double,
        blockType: WorkoutBlockType
    ) -> Int {
        let fatigueExtra = Int((fatiguePenalty * 18).rounded())
        let typeAdjustment: Int
        switch blockType {
        case .single:
            typeAdjustment = 0
        case .superset:
            typeAdjustment = -8
        case .circuit:
            typeAdjustment = -12
        }

        return max(20, base + fatigueExtra + typeAdjustment)
    }

    private static func makeProgression(
        for item: ExerciseCatalogItemDTO,
        snapshot: ExercisePerformanceSnapshot?,
        repsText: String,
        goal: TrainingGoal,
        intensity: WorkoutIntensity
    ) -> ProgressionPlan {
        guard let snapshot else {
            return ProgressionPlan(
                suggestedWeightKg: nil,
                note: "Sin historial. Registra tus series para activar progresión automática."
            )
        }

        guard let range = parseRepRange(repsText) else {
            return ProgressionPlan(
                suggestedWeightKg: snapshot.lastWeightKg,
                note: "Mantén ritmo y técnica; esta variante se guía por tiempo."
            )
        }

        let lastWeight = snapshot.lastWeightKg
        let lastReps = snapshot.lastReps
        let minTarget = range.min
        let maxTarget = range.max

        let incrementStep: Double
        switch intensity {
        case .heavy: incrementStep = 2.5
        case .moderate: incrementStep = 1.25
        case .light: incrementStep = 1.0
        }

        var delta = 0.0

        if lastReps >= maxTarget {
            switch goal {
            case .gainStrength, .gainMuscle:
                delta = incrementStep
            case .defineMuscle:
                delta = incrementStep * 0.5
            case .loseFat, .improveConditioning:
                delta = 0
            }
        } else if lastReps < minTarget {
            switch goal {
            case .gainStrength, .gainMuscle:
                delta = -incrementStep * 0.5
            case .defineMuscle, .loseFat, .improveConditioning:
                delta = 0
            }
        }

        let rawSuggested = max(0, lastWeight + delta)
        let suggested = roundToNearest(rawSuggested, step: 0.5)

        let note: String
        if delta > 0 {
            note = "Progresión: +\(formatted(delta)) kg respecto a tu último registro."
        } else if delta < 0 {
            note = "Ajuste técnico: baja ~\(formatted(abs(delta))) kg para cumplir rango objetivo."
        } else {
            note = "Mantén \(formatted(lastWeight)) kg y busca \(minTarget)-\(maxTarget) reps limpias."
        }

        _ = item

        return ProgressionPlan(
            suggestedWeightKg: suggested,
            note: note
        )
    }

    private static func parseRepRange(_ repsText: String) -> (min: Int, max: Int)? {
        let normalizedText = normalized(repsText)
        if normalizedText.contains("seg") || normalizedText.contains("sec") {
            return nil
        }

        let numbers = normalizedText
            .components(separatedBy: CharacterSet.decimalDigits.inverted)
            .compactMap(Int.init)

        guard !numbers.isEmpty else { return nil }
        if numbers.count >= 2 {
            return (min: min(numbers[0], numbers[1]), max: max(numbers[0], numbers[1]))
        }

        let value = numbers[0]
        return (min: max(1, value - 1), max: value + 1)
    }

    private static func roundToNearest(_ value: Double, step: Double) -> Double {
        guard step > 0 else { return value }
        return (value / step).rounded() * step
    }

    private static func formatted(_ value: Double) -> String {
        if value.rounded() == value {
            return String(format: "%.0f", value)
        }
        return String(format: "%.1f", value)
    }

    private static func performanceSnapshot(
        for item: ExerciseCatalogItemDTO,
        performanceBySlug: [String: ExercisePerformanceSnapshot]
    ) -> ExercisePerformanceSnapshot? {
        let slugKey = normalized(item.slug)
        if let bySlug = performanceBySlug[slugKey] {
            return bySlug
        }

        let idKey = normalized(item.id)
        return performanceBySlug[idKey]
    }

    private static func inferIntensity(for item: ExerciseCatalogItemDTO) -> WorkoutIntensity {
        let blob = normalized([item.name, item.slug, item.muscles.map(\.name).joined(separator: " ")].joined(separator: " "))

        if heavyKeywords.contains(where: { blob.contains($0) }) {
            return .heavy
        }

        if lightKeywords.contains(where: { blob.contains($0) }) {
            return .light
        }

        return .moderate
    }

    private static let heavyKeywords: [String] = [
        "sentadilla", "squat", "hack", "peso muerto", "deadlift", "hip thrust",
        "press banca", "bench press", "press militar", "overhead press", "remo con barra",
        "pull up lastrado", "dominadas lastradas", "prensa"
    ]

    private static let lightKeywords: [String] = [
        "abdomen", "abdominal", "crunch", "plancha", "core", "cuerda", "jump rope",
        "cardio", "bicicleta", "bike", "ergometro", "ergometer", "pantorrilla",
        "elevacion", "elevación", "curl", "extension", "extensión"
    ]

    private static func filterByEquipment(
        _ exercises: [ExerciseCatalogItemDTO],
        equipment: Set<TrainingEquipmentOption>
    ) -> [ExerciseCatalogItemDTO] {
        let allowedTokens: Set<String> = Set(
            equipment.flatMap { option in
                ([option.rawValue] + option.aliases).map(normalized)
            }
        )

        return exercises.filter { item in
            guard !item.equipment.isEmpty else { return true }

            let requirements = item.equipment.map { entry in
                [normalized(entry.name), normalized(entry.id)]
            }

            return requirements.allSatisfy { pair in
                let compactPair = pair.filter { !$0.isEmpty }
                guard !compactPair.isEmpty else { return true }

                return compactPair.contains { requirement in
                    allowedTokens.contains { token in
                        token.contains(requirement) || requirement.contains(token)
                    }
                }
            }
        }
    }

    private static func filterByFocus(
        _ exercises: [ExerciseCatalogItemDTO],
        focus: TrainingFocusArea
    ) -> [ExerciseCatalogItemDTO] {
        let keywords = focusKeywords[focus] ?? []
        guard !keywords.isEmpty else { return exercises }

        return exercises.filter { exercise in
            let blob = normalized([
                exercise.name,
                exercise.slug,
                exercise.muscles.map(\.name).joined(separator: " ")
            ].joined(separator: " "))

            return keywords.contains { blob.contains($0) }
        }
    }

    private static let focusKeywords: [TrainingFocusArea: [String]] = [
        .push: ["pecho", "hombro", "tricep", "trícep", "deltoid", "push"],
        .pull: ["espalda", "dorsal", "bicep", "bícep", "trapec", "remo", "jalon", "jalón", "pull"],
        .legs: ["pierna", "cuadricep", "cuádricep", "femoral", "glute", "isquio", "pantorrilla", "sentadilla", "lunge"],
        .upper: ["pecho", "hombro", "espalda", "dorsal", "bicep", "bícep", "tricep", "trícep", "brazo"],
        .lower: ["pierna", "cuadricep", "cuádricep", "femoral", "glute", "isquio", "pantorrilla", "sentadilla", "lunge"],
        .fullBody: ["cuerpo completo", "full body", "cardio", "core", "sentadilla", "remo", "press", "zancada"]
    ]

    private static let muscleProfiles: [TrainingFocusArea: MusclePriorityProfile] = [
        .push: .init(
            primary: ["pecho", "hombro", "deltoid", "tricep", "trícep"],
            secondary: ["core", "serrato", "trapec"]
        ),
        .pull: .init(
            primary: ["espalda", "dorsal", "bicep", "bícep", "trapec", "romboid"],
            secondary: ["core", "posterior", "antebrazo"]
        ),
        .legs: .init(
            primary: ["pierna", "cuadricep", "cuádricep", "femoral", "glute", "isquio", "pantorrilla"],
            secondary: ["core", "abductor", "aductor"]
        ),
        .upper: .init(
            primary: ["pecho", "hombro", "espalda", "dorsal", "bicep", "bícep", "tricep", "trícep"],
            secondary: ["core", "trapec", "antebrazo"]
        ),
        .lower: .init(
            primary: ["pierna", "cuadricep", "cuádricep", "femoral", "glute", "isquio", "pantorrilla"],
            secondary: ["core", "abductor", "aductor"]
        ),
        .fullBody: .init(
            primary: ["pecho", "espalda", "pierna", "cuadricep", "cuádricep", "glute", "core"],
            secondary: ["hombro", "bicep", "bícep", "tricep", "trícep", "cardio"]
        )
    ]

    private static func score(
        _ item: ExerciseCatalogItemDTO,
        focus: TrainingFocusArea,
        goal: TrainingGoal,
        fatiguePenalty: Double
    ) -> Double {
        let intensity = inferIntensity(for: item)
        let blob = normalized([
            item.name,
            item.slug,
            item.muscles.map(\.name).joined(separator: " ")
        ].joined(separator: " "))

        let keywordMatches = Double((focusKeywords[focus] ?? []).reduce(0) { partial, keyword in
            partial + (blob.contains(keyword) ? 1 : 0)
        })

        let muscleScore = musclePriorityScore(item, focus: focus)

        let intensityScore: Double
        switch goal {
        case .gainStrength:
            intensityScore = intensity == .heavy ? 2.0 : intensity == .moderate ? 1.0 : 0.5
        case .gainMuscle:
            intensityScore = intensity == .moderate ? 2.0 : intensity == .heavy ? 1.6 : 1.0
        case .defineMuscle, .loseFat, .improveConditioning:
            intensityScore = intensity == .light ? 2.0 : intensity == .moderate ? 1.3 : 0.6
        }

        let fatigueAdjustment: Double
        switch intensity {
        case .heavy:
            fatigueAdjustment = fatiguePenalty * 0.55
        case .moderate:
            fatigueAdjustment = fatiguePenalty * 0.25
        case .light:
            fatigueAdjustment = fatiguePenalty * 0.08
        }

        let equipmentSimplicity = item.equipment.count <= 1 ? 0.7 : 0.2

        return muscleScore * 1.9 + keywordMatches * 0.8 + intensityScore + equipmentSimplicity - fatigueAdjustment
    }

    private static func musclePriorityScore(
        _ item: ExerciseCatalogItemDTO,
        focus: TrainingFocusArea
    ) -> Double {
        guard let profile = muscleProfiles[focus] else { return 0 }

        let muscles = item.muscles.map { normalized($0.name) }
        guard !muscles.isEmpty else { return 0 }

        var score = 0.0

        for (index, muscle) in muscles.enumerated() {
            let isPrimary = profile.primary.contains { muscle.contains($0) || $0.contains(muscle) }
            let isSecondary = profile.secondary.contains { muscle.contains($0) || $0.contains(muscle) }

            if isPrimary {
                score += index == 0 ? 2.8 : 1.4
            } else if isSecondary {
                score += index == 0 ? 1.4 : 0.8
            }
        }

        return score
    }

    private static func blockTitle(type: WorkoutBlockType, index: Int, goal: TrainingGoal) -> String {
        switch type {
        case .single:
            switch goal {
            case .gainStrength: return "Bloque de fuerza \(index)"
            case .gainMuscle: return "Bloque principal \(index)"
            case .defineMuscle, .loseFat, .improveConditioning: return "Bloque técnico \(index)"
            }
        case .superset:
            return "Superset \(index)"
        case .circuit:
            return "Circuito \(index)"
        }
    }

    private static func blockSubtitle(type: WorkoutBlockType, rounds: Int?) -> String {
        switch type {
        case .single:
            return "Descansa al terminar cada serie según la prescripción."
        case .superset:
            let roundsText = rounds.map { "\($0) rondas" } ?? "Rondas"
            return "Alterna ejercicios sin descanso. \(roundsText)."
        case .circuit:
            let roundsText = rounds.map { "\($0) rondas" } ?? "Rondas"
            return "Completa todos los ejercicios seguidos. \(roundsText)."
        }
    }

    private static func estimateDurationMinutes(
        fallbackDuration: Int,
        blocks: [WorkoutPlanBlock]
    ) -> Int {
        guard !blocks.isEmpty else { return fallbackDuration }

        var totalSeconds = 0

        for block in blocks {
            switch block.type {
            case .single:
                for exercise in block.exercises {
                    let workSeconds = estimateWorkSeconds(repsText: exercise.repsText)
                    let perSet = workSeconds + exercise.restSeconds
                    totalSeconds += perSet * exercise.sets
                }

            case .superset, .circuit:
                let rounds = block.rounds ?? 3
                let workPerRound = block.exercises.reduce(0) { partial, exercise in
                    partial + estimateWorkSeconds(repsText: exercise.repsText)
                }
                totalSeconds += workPerRound * rounds
                if rounds > 1 {
                    totalSeconds += (block.restBetweenRounds ?? 60) * (rounds - 1)
                }
            }
        }

        let estimated = Int(ceil(Double(totalSeconds) / 60.0))
        if estimated == 0 {
            return fallbackDuration
        }

        let lowerBound = max(20, fallbackDuration - 12)
        let upperBound = fallbackDuration + 12
        return min(max(estimated, lowerBound), upperBound)
    }

    private static func estimateWorkSeconds(repsText: String) -> Int {
        let normalizedText = normalized(repsText)

        if normalizedText.contains("seg") || normalizedText.contains("sec") {
            let digits = normalizedText
                .components(separatedBy: CharacterSet.decimalDigits.inverted)
                .compactMap(Int.init)
            return digits.max() ?? 40
        }

        let numbers = normalizedText
            .components(separatedBy: CharacterSet.decimalDigits.inverted)
            .compactMap(Int.init)

        if let maxReps = numbers.max() {
            return min(70, max(25, maxReps * 3))
        }

        return 40
    }

    private static func fatigueLabel(for penalty: Double) -> String {
        switch penalty {
        case ..<0.6: return "baja"
        case 0.6..<1.6: return "media"
        default: return "alta"
        }
    }

    private static func rationale(
        goal: TrainingGoal,
        split: TrainingSplit,
        focus: TrainingFocusArea,
        durationMinutes: Int,
        equipmentCount: Int,
        fatiguePenalty: Double
    ) -> String {
        "Sugerencia generada con IA por objetivo (\(goal.rawValue)), división (\(split.rawValue)), enfoque de hoy (\(focus.rawValue)), duración objetivo (\(durationMinutes) min), equipo disponible (\(equipmentCount) opciones) y fatiga estimada (\(fatigueLabel(for: fatiguePenalty)))."
    }

    private static func normalized(_ value: String) -> String {
        value
            .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
    }
}
