import SwiftUI
import Foundation

// MARK: - Modelos

enum MuscleGroup: String, CaseIterable, Identifiable, Codable {
    case pecho = "Pecho"
    case espalda = "Espalda"
    case piernas = "Piernas"
    case hombros = "Hombros"
    case brazos = "Brazos"
    case core = "Core"
    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .pecho: return "💪"
        case .espalda: return "🦴"
        case .piernas: return "🦵"
        case .hombros: return "🏋️‍♂️"
        case .brazos: return "🫱"
        case .core: return "🧱"
        }
    }
}

struct Exercise: Identifiable, Hashable, Codable {
    var id: UUID = .init()
    var name: String
    var sets: Int
    var reps: Int
    var suggestedWeight: String // "80 kg", "BW", "seg", etc.
    var group: MuscleGroup
    var notes: String? = nil
}

struct Routine: Identifiable, Hashable, Codable {
    var id: UUID = .init()
    var title: String
    var group: MuscleGroup
    var estimatedMinutes: Int
    var difficulty: String // "Principiante", "Intermedio", "Avanzado"
    var exercises: [Exercise]
}

struct CompletedWorkout: Identifiable, Codable {
    var id: UUID = .init()
    var date: Date
    var group: MuscleGroup
    var routineId: UUID
}

// MARK: - Datos demo

let demoRoutines: [Routine] = [
    // Pecho
    Routine(title: "Pecho Fuerte 1", group: .pecho, estimatedMinutes: 45, difficulty: "Intermedio", exercises: [
        Exercise(name: "Press banca plano", sets: 4, reps: 8, suggestedWeight: "80 kg", group: .pecho),
        Exercise(name: "Aperturas mancuernas", sets: 3, reps: 12, suggestedWeight: "14 kg", group: .pecho),
        Exercise(name: "Fondos paralelas", sets: 3, reps: 10, suggestedWeight: "BW", group: .pecho)
    ]),
    Routine(title: "Pecho Volumen 2", group: .pecho, estimatedMinutes: 40, difficulty: "Principiante", exercises: [
        Exercise(name: "Press inclinado mancuernas", sets: 4, reps: 10, suggestedWeight: "22 kg", group: .pecho),
        Exercise(name: "Crossover poleas", sets: 3, reps: 12, suggestedWeight: "Moderado", group: .pecho)
    ]),

    // Espalda
    Routine(title: "Espalda Ancha 1", group: .espalda, estimatedMinutes: 45, difficulty: "Intermedio", exercises: [
        Exercise(name: "Dominadas", sets: 4, reps: 8, suggestedWeight: "BW", group: .espalda),
        Exercise(name: "Remo con barra", sets: 4, reps: 8, suggestedWeight: "60 kg", group: .espalda),
        Exercise(name: "Jalón al pecho", sets: 3, reps: 12, suggestedWeight: "Moderado", group: .espalda)
    ]),
    Routine(title: "Espalda Base 2", group: .espalda, estimatedMinutes: 35, difficulty: "Principiante", exercises: [
        Exercise(name: "Remo mancuerna", sets: 3, reps: 12, suggestedWeight: "18 kg", group: .espalda),
        Exercise(name: "Jalón cerrado", sets: 3, reps: 12, suggestedWeight: "Moderado", group: .espalda)
    ]),

    // Piernas
    Routine(title: "Piernas Potentes 1", group: .piernas, estimatedMinutes: 50, difficulty: "Intermedio", exercises: [
        Exercise(name: "Sentadilla trasera", sets: 4, reps: 6, suggestedWeight: "100 kg", group: .piernas),
        Exercise(name: "Prensa de piernas", sets: 3, reps: 12, suggestedWeight: "150 kg", group: .piernas),
        Exercise(name: "Curl femoral", sets: 3, reps: 12, suggestedWeight: "Moderado", group: .piernas)
    ]),
    Routine(title: "Piernas Base 2", group: .piernas, estimatedMinutes: 40, difficulty: "Principiante", exercises: [
        Exercise(name: "Sentadilla goblet", sets: 4, reps: 10, suggestedWeight: "24 kg", group: .piernas),
        Exercise(name: "Desplantes", sets: 3, reps: 12, suggestedWeight: "BW", group: .piernas)
    ]),

    // Hombros
    Routine(title: "Hombro 3D 1", group: .hombros, estimatedMinutes: 40, difficulty: "Intermedio", exercises: [
        Exercise(name: "Press militar", sets: 4, reps: 8, suggestedWeight: "40 kg", group: .hombros),
        Exercise(name: "Elevaciones laterales", sets: 3, reps: 12, suggestedWeight: "8 kg", group: .hombros),
        Exercise(name: "Pájaros", sets: 3, reps: 12, suggestedWeight: "6 kg", group: .hombros)
    ]),
    Routine(title: "Hombro Base 2", group: .hombros, estimatedMinutes: 35, difficulty: "Principiante", exercises: [
        Exercise(name: "Press Arnold", sets: 4, reps: 10, suggestedWeight: "16 kg", group: .hombros),
        Exercise(name: "Elevación frontal", sets: 3, reps: 12, suggestedWeight: "6 kg", group: .hombros)
    ]),

    // Brazos
    Routine(title: "Brazos Énfasis Bíceps", group: .brazos, estimatedMinutes: 35, difficulty: "Intermedio", exercises: [
        Exercise(name: "Curl bíceps barra", sets: 4, reps: 10, suggestedWeight: "30 kg", group: .brazos),
        Exercise(name: "Curl martillo", sets: 3, reps: 12, suggestedWeight: "14 kg", group: .brazos),
        Exercise(name: "Fondos paralelas", sets: 3, reps: 10, suggestedWeight: "BW", group: .brazos)
    ]),
    Routine(title: "Brazos Base 2", group: .brazos, estimatedMinutes: 30, difficulty: "Principiante", exercises: [
        Exercise(name: "Curl mancuerna alterno", sets: 3, reps: 12, suggestedWeight: "12 kg", group: .brazos),
        Exercise(name: "Extensión tríceps cuerda", sets: 3, reps: 12, suggestedWeight: "Moderado", group: .brazos)
    ]),

    // Core
    Routine(title: "Core Funcional 1", group: .core, estimatedMinutes: 25, difficulty: "Intermedio", exercises: [
        Exercise(name: "Plancha", sets: 3, reps: 45, suggestedWeight: "seg", group: .core),
        Exercise(name: "Crunch cable", sets: 4, reps: 15, suggestedWeight: "25 kg", group: .core),
        Exercise(name: "Elevación de piernas", sets: 3, reps: 12, suggestedWeight: "BW", group: .core)
    ]),
    Routine(title: "Core Base 2", group: .core, estimatedMinutes: 20, difficulty: "Principiante", exercises: [
        Exercise(name: "Dead bug", sets: 3, reps: 10, suggestedWeight: "BW", group: .core),
        Exercise(name: "Plancha lateral", sets: 3, reps: 30, suggestedWeight: "seg", group: .core)
    ])
]

// MARK: - Persistencia simple

final class TrainingStore: ObservableObject {
    @Published var history: [CompletedWorkout] = [] { didSet { save() } }

    private let key = "xibapp.training.history"

    init() { load() }

    func addCompletion(for routine: Routine) {
        history.append(.init(date: Date(), group: routine.group, routineId: routine.id))
    }

    func lastDate(for group: MuscleGroup) -> Date? {
        history.filter { $0.group == group }.map { $0.date }.max()
    }

    private func save() {
        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let items = try? JSONDecoder().decode([CompletedWorkout].self, from: data) else { return }
        history = items
    }
}

// MARK: - Sugeridor

struct RoutineSuggestionEngine {
    static func suggestNext(from routines: [Routine], store: TrainingStore, today: Date = .init()) -> Routine? {
        // Regla: prioriza el grupo que lleve más tiempo sin entrenarse
        let groups = MuscleGroup.allCases
        let sorted = groups.sorted { (g1, g2) in
            let d1 = store.lastDate(for: g1) ?? .distantPast
            let d2 = store.lastDate(for: g2) ?? .distantPast
            return d1 < d2 // el más antiguo primero
        }
        guard let targetGroup = sorted.first,
              let candidates = routinesByGroup(routines)[targetGroup], !candidates.isEmpty else { return nil }

        // Evita repetir exactamente la última rutina del mismo grupo (si existe)
        let lastRoutineId = store.history.last(where: { $0.group == targetGroup })?.routineId
        if let alt = candidates.first(where: { $0.id != lastRoutineId }) { return alt }
        return candidates.first
    }

    static func routinesByGroup(_ routines: [Routine]) -> [MuscleGroup: [Routine]] {
        Dictionary(grouping: routines, by: { $0.group })
    }
}

// MARK: - Vistas

struct RoutinesHomeView: View {
    @StateObject private var store = TrainingStore()
    private let routines: [Routine] = demoRoutines

    @State private var selectedGroup: MuscleGroup? = nil
    @State private var suggested: Routine? = nil

    var body: some View {
        ZStack {
            ObsidianBackground().ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    header
                    suggestionCard
                    groupChips

                    if let g = selectedGroup {
                        GroupRoutinesSection(group: g, routines: routinesFor(group: g), onStart: markCompleted)
                    } else {
                        allGroupsSections
                    }
                }
                .padding(16)
                .padding(.bottom, 28)
            }
        }
        .onAppear { suggested = RoutineSuggestionEngine.suggestNext(from: routines, store: store) }
        .preferredColorScheme(.dark)
        .tint(Brand.magentaCTA)
    }

    private var header: some View {
        GlassCard {
            HStack {
                Text("Rutinas por grupo muscular")
                    .font(AppFont.oxaniumBold(20))
                    .crystalTitle()
                Spacer()
                Text("Historial: \(store.history.count)")
                    .font(AppFont.oxaniumRegular(12))
                    .foregroundStyle(.white.opacity(0.8))
            }
        }
    }

    private var suggestionCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 10) {
                Text("Sugerencia de hoy")
                    .font(AppFont.oxaniumBold(16))
                    .foregroundStyle(Brand.jadeGlow)

                if let s = suggested {
                    HStack(alignment: .top, spacing: 12) {
                        Text(s.group.emoji).font(.system(size: 28))
                        VStack(alignment: .leading, spacing: 4) {
                            Text(s.title)
                                .font(AppFont.oxaniumBold(18))
                                .foregroundStyle(.white)
                            Text("\(s.group.rawValue) • \(s.estimatedMinutes) min • \(s.difficulty)")
                                .font(AppFont.oxaniumRegular(13))
                                .foregroundStyle(.white.opacity(0.85))
                        }
                        Spacer()
                    }

                    Button {
                        markCompleted(s)
                    } label: {
                        Text("Marcar completada")
                            .font(AppFont.oxaniumBold(16))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GoldGlassButtonStyle())
                } else {
                    Text("Aún no hay sugerencia—entrena cualquier grupo para empezar el ciclo")
                        .font(AppFont.oxaniumRegular(13))
                        .foregroundStyle(.white.opacity(0.85))
                }
            }
        }
    }

    private var groupChips: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 10) {
                Text("Filtrar por grupo")
                    .font(AppFont.oxaniumBold(16))
                    .foregroundStyle(.white)

                let cols = [GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8)]
                LazyVGrid(columns: cols, spacing: 8) {
                    ForEach(MuscleGroup.allCases) { g in
                        GroupChip(group: g, isSelected: selectedGroup == g) {
                            selectedGroup = (selectedGroup == g) ? nil : g
                        }
                    }
                }
            }
        }
    }

    private var allGroupsSections: some View {
        VStack(spacing: 16) {
            ForEach(MuscleGroup.allCases) { g in
                GroupRoutinesSection(group: g, routines: routinesFor(group: g), onStart: markCompleted)
            }
        }
    }

    private func routinesFor(group: MuscleGroup) -> [Routine] {
        RoutineSuggestionEngine.routinesByGroup(routines)[group] ?? []
    }

    private func markCompleted(_ r: Routine) {
        store.addCompletion(for: r)
        suggested = RoutineSuggestionEngine.suggestNext(from: routines, store: store)
    }
}

// MARK: - Componentes UI

struct GroupChip: View {
    let group: MuscleGroup
    let isSelected: Bool
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Text(group.emoji)
                Text(group.rawValue)
                    .font(AppFont.oxaniumRegular(13))
            }
            .foregroundStyle(isSelected ? .black : .white)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(
                        isSelected
                            ? AnyShapeStyle(Brand.goldGlow)
                            : AnyShapeStyle(.thinMaterial)
                    )
            )

            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Brand.borderLight, lineWidth: 0.8)
            )
        }
        .buttonStyle(.plain)
    }
}

struct GroupRoutinesSection: View {
    let group: MuscleGroup
    let routines: [Routine]
    var onStart: (Routine) -> Void

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("\(group.emoji) \(group.rawValue)")
                        .font(AppFont.oxaniumBold(18))
                        .foregroundStyle(Brand.jadeGlow)
                    Spacer()
                    Text("\(routines.count) rutinas")
                        .font(AppFont.oxaniumRegular(12))
                        .foregroundStyle(.white.opacity(0.8))
                }

                ForEach(routines) { r in
                    RoutineRow(routine: r) { onStart(r) }
                }
            }
        }
    }
}

struct RoutineRow: View {
    let routine: Routine
    var onStart: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top) {
                Text(routine.title)
                    .font(AppFont.oxaniumBold(16))
                    .foregroundStyle(.white)
                Spacer()
                Text(routine.difficulty)
                    .font(AppFont.oxaniumBold(11))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Capsule().fill(Brand.jadeGlow.opacity(0.14)))
                    .overlay(Capsule().stroke(Brand.borderLight, lineWidth: 0.8))
                    .foregroundStyle(Brand.jadeGlow)
            }
            Text("\(routine.group.rawValue) • \(routine.estimatedMinutes) min • \(routine.exercises.count) ejercicios")
                .font(AppFont.oxaniumRegular(13))
                .foregroundStyle(.white.opacity(0.85))

            VStack(alignment: .leading, spacing: 4) {
                ForEach(routine.exercises.prefix(3)) { ex in
                    Text("• \(ex.name) – \(ex.sets)x\(ex.reps)  \(ex.suggestedWeight)")
                        .font(AppFont.oxaniumRegular(12))
                        .foregroundStyle(.white.opacity(0.9))
                }
                if routine.exercises.count > 3 {
                    Text("… y más")
                        .font(AppFont.oxaniumRegular(12))
                        .foregroundStyle(.white.opacity(0.7))
                }
            }

            Button(action: onStart) {
                Text("Marcar completada")
                    .font(AppFont.oxaniumBold(14))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(GoldGlassButtonStyle())
        }
        .padding(10)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Brand.borderLight, lineWidth: 0.8))
    }
}

#Preview {
    NavigationStack { RoutinesHomeView() }
        .environment(\.locale, Locale(identifier: "es"))
        .preferredColorScheme(.dark)
        .tint(Brand.magentaCTA)
}
