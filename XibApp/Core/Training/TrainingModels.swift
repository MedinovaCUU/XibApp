import Foundation

enum TrainingGoal: String, CaseIterable, Codable, Identifiable {
    case gainMuscle = "Ganar músculo"
    case loseFat = "Reducir peso corporal"
    case defineMuscle = "Definir músculo"
    case gainStrength = "Ganar fuerza"
    case improveConditioning = "Mejorar condición física"

    var id: String { rawValue }
}

enum TrainingSplit: String, CaseIterable, Codable, Identifiable {
    case pushPullLegs = "Empuje/Jalón/Piernas"
    case upperLowerFullBody = "Superior/Inferior/Cuerpo completo"
    case fullBody = "Cuerpo completo"
    case upperLower = "Tren superior/Tren inferior"

    var id: String { rawValue }
}

enum TrainingFocusArea: String, Codable, CaseIterable, Identifiable {
    case push = "Empuje"
    case pull = "Jalón"
    case legs = "Piernas"
    case upper = "Superior"
    case lower = "Inferior"
    case fullBody = "Cuerpo completo"

    var id: String { rawValue }
}

enum TrainingEquipmentOption: String, CaseIterable, Codable, Identifiable {
    case bodyweight = "Peso corporal"
    case barbell = "Barra"
    case ezBar = "Barra Z"
    case dumbbells = "Mancuernas"
    case bench = "Banco"
    case machine = "Máquina"
    case cable = "Polea"
    case kettlebell = "Kettlebell"
    case band = "Banda elástica"
    case pullupBar = "Barra dominadas"
    case parallelBars = "Paralelas"
    case plate = "Discos"
    case box = "Cajón"
    case jumpRope = "Cuerda"
    case bike = "Bicicleta estática"
    case rower = "Remo ergómetro"

    var id: String { rawValue }

    var aliases: [String] {
        switch self {
        case .bodyweight: return ["peso corporal", "bodyweight"]
        case .barbell: return ["barra", "barbell"]
        case .ezBar: return ["barra z", "ez bar", "ez_bar"]
        case .dumbbells: return ["mancuernas", "mancuerna", "dumbbell", "dumbbells"]
        case .bench: return ["banco", "bench"]
        case .machine: return ["maquina", "máquina", "machine"]
        case .cable: return ["polea", "cable"]
        case .kettlebell: return ["kettlebell", "kettlebells"]
        case .band: return ["banda elastica", "banda elástica", "band", "bands"]
        case .pullupBar: return ["barra de dominadas", "barra dominadas", "pullup bar", "pullup_bar"]
        case .parallelBars: return ["paralelas", "parallel bars", "parallel_bars"]
        case .plate: return ["disco", "discos", "plate", "plates"]
        case .box: return ["cajon", "cajón", "box", "plyo box", "plyo_box"]
        case .jumpRope: return ["cuerda", "jump rope", "jump_rope"]
        case .bike: return ["bicicleta estatica", "bicicleta estática", "bike", "air bike", "stationary bike"]
        case .rower: return ["remo ergometro", "remo ergómetro", "rower", "ergometer"]
        }
    }
}

struct TrainingPreferences: Codable, Equatable {
    var goal: TrainingGoal = .gainMuscle
    var split: TrainingSplit = .pushPullLegs
    var sessionDurationMinutes: Int = 60
    var availableEquipment: Set<TrainingEquipmentOption> = [.bodyweight, .dumbbells, .bench]

    static let `default` = TrainingPreferences()

    var refreshKey: String {
        let equipmentKey = availableEquipment
            .map(\.rawValue)
            .sorted()
            .joined(separator: "|")

        return "\(goal.rawValue)-\(split.rawValue)-\(sessionDurationMinutes)-\(equipmentKey)"
    }
}

struct CompletedTrainingSession: Identifiable, Codable, Hashable {
    var id: UUID
    var date: Date
    var split: TrainingSplit
    var focus: TrainingFocusArea
    var plannedMinutes: Int
    var title: String

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        split: TrainingSplit,
        focus: TrainingFocusArea,
        plannedMinutes: Int,
        title: String
    ) {
        self.id = id
        self.date = date
        self.split = split
        self.focus = focus
        self.plannedMinutes = plannedMinutes
        self.title = title
    }
}

enum WorkoutBlockType: String, Codable {
    case single
    case superset
    case circuit
}

struct WorkoutExercisePrescription: Identifiable, Hashable {
    let id: String
    let exercise: ExerciseCatalogItemDTO
    let sets: Int
    let repsText: String
    let restSeconds: Int
    let notes: String
    let suggestedWeightKg: Double?
    let progressionNote: String
}

struct WorkoutExerciseFlowContext: Hashable {
    let blockType: WorkoutBlockType
    let nextExerciseInBlock: WorkoutExercisePrescription?
    let nextExerciseOverall: WorkoutExercisePrescription?
}

struct ExercisePerformanceSnapshot: Identifiable, Codable, Hashable {
    let id: String
    var exerciseID: String
    var exerciseSlug: String
    var lastWeightKg: Double
    var bestWeightKg: Double
    var lastReps: Int
    var sessionsCount: Int
    var updatedAt: Date

    init(
        id: String,
        exerciseID: String,
        exerciseSlug: String,
        lastWeightKg: Double,
        bestWeightKg: Double,
        lastReps: Int,
        sessionsCount: Int,
        updatedAt: Date
    ) {
        self.id = id
        self.exerciseID = exerciseID
        self.exerciseSlug = exerciseSlug
        self.lastWeightKg = lastWeightKg
        self.bestWeightKg = bestWeightKg
        self.lastReps = lastReps
        self.sessionsCount = sessionsCount
        self.updatedAt = updatedAt
    }
}

struct WorkoutPlanBlock: Identifiable, Hashable {
    let id: UUID
    let type: WorkoutBlockType
    let title: String
    let subtitle: String
    let exercises: [WorkoutExercisePrescription]
    let rounds: Int?
    let restBetweenRounds: Int?

    init(
        id: UUID = UUID(),
        type: WorkoutBlockType,
        title: String,
        subtitle: String,
        exercises: [WorkoutExercisePrescription],
        rounds: Int? = nil,
        restBetweenRounds: Int? = nil
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.exercises = exercises
        self.rounds = rounds
        self.restBetweenRounds = restBetweenRounds
    }
}

struct SuggestedWorkoutPlan: Identifiable, Hashable {
    let id: UUID
    let generatedAt: Date
    let goal: TrainingGoal
    let split: TrainingSplit
    let focus: TrainingFocusArea
    let title: String
    let subtitle: String
    let estimatedMinutes: Int
    let rationale: String
    let blocks: [WorkoutPlanBlock]

    init(
        id: UUID = UUID(),
        generatedAt: Date = Date(),
        goal: TrainingGoal,
        split: TrainingSplit,
        focus: TrainingFocusArea,
        title: String,
        subtitle: String,
        estimatedMinutes: Int,
        rationale: String,
        blocks: [WorkoutPlanBlock]
    ) {
        self.id = id
        self.generatedAt = generatedAt
        self.goal = goal
        self.split = split
        self.focus = focus
        self.title = title
        self.subtitle = subtitle
        self.estimatedMinutes = estimatedMinutes
        self.rationale = rationale
        self.blocks = blocks
    }
}
