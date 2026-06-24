import SwiftUI

struct SuggestedWorkoutView: View {
    @EnvironmentObject private var preferencesStore: TrainingPreferencesStore
    @EnvironmentObject private var historyStore: TrainingSessionHistoryStore
    @EnvironmentObject private var performanceStore: ExercisePerformanceStore

    @StateObject private var viewModel = SuggestedWorkoutViewModel()

    private var refreshToken: String {
        let sessionsToken = historyStore.sessions
            .prefix(4)
            .map { "\($0.id.uuidString)-\($0.date.timeIntervalSince1970)" }
            .joined(separator: "|")
        let performanceToken = performanceStore.snapshotsBySlug
            .values
            .sorted { $0.updatedAt > $1.updatedAt }
            .prefix(8)
            .map { "\($0.exerciseSlug)-\($0.updatedAt.timeIntervalSince1970)-\($0.lastWeightKg)-\($0.lastReps)" }
            .joined(separator: "|")

        return "\(preferencesStore.preferences.refreshKey)#\(historyStore.sessions.count)#\(sessionsToken)#\(performanceStore.snapshotsBySlug.count)#\(performanceToken)"
    }

    var body: some View {
        ZStack {
            ObsidianBackground()
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 14) {
                    headerCard
                    content
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .navigationTitle("Entrenamiento sugerido")
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
        .task(id: refreshToken) {
            viewModel.loadIfNeeded(
                preferences: preferencesStore.preferences,
                history: historyStore.sessions,
                performanceBySlug: performanceStore.snapshotsBySlug
            )
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    TrainingPreferencesView()
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
            }
        }
    }

    private var headerCard: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 8) {
                Text("Sugerencia inteligente")
                    .font(AppFont.oxaniumBold(20))
                    .crystalTitle()

                Text("La sesión se genera con tu meta, división, equipo disponible, duración y tu historial reciente.")
                    .font(AppFont.oxaniumRegular(13))
                    .foregroundStyle(.white.opacity(0.84))
            }
            .frame(maxWidth: .infinity, minHeight: ShapeTokens.compactRowMinHeight, alignment: .topLeading)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            loadingState

        case .failed(let message):
            errorState(message: message)

        case .loaded(let plan):
            loadedState(plan: plan)
        }
    }

    private var loadingState: some View {
        LazyVStack(spacing: 10) {
            ForEach(0..<5, id: \.self) { _ in
                ObsidianGlassCard {
                    VStack(alignment: .leading, spacing: 8) {
                        SkeletonText(width: .infinity, height: 20)
                        SkeletonText(width: .infinity, height: 14)
                        SkeletonChips(count: 3)
                    }
                    .frame(maxWidth: .infinity, minHeight: ShapeTokens.rowMinHeight, alignment: .topLeading)
                }
            }
        }
    }

    private func errorState(message: String) -> some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 10) {
                Text("No se pudo generar el entrenamiento")
                    .font(AppFont.oxaniumBold(16))
                    .foregroundStyle(.white)

                Text(message)
                    .font(AppFont.oxaniumRegular(13))
                    .foregroundStyle(.white.opacity(0.82))

                Button {
                    viewModel.retry(
                        preferences: preferencesStore.preferences,
                        history: historyStore.sessions,
                        performanceBySlug: performanceStore.snapshotsBySlug
                    )
                } label: {
                    Text("Reintentar")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
            }
        }
    }

    private func loadedState(plan: SuggestedWorkoutPlan) -> some View {
        VStack(spacing: 12) {
            planSummaryCard(plan: plan)

            if plan.blocks.isEmpty {
                ObsidianGlassCard {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Sin ejercicios disponibles")
                            .font(AppFont.oxaniumBold(16))
                            .foregroundStyle(.white)
                        Text("Actualiza el equipo disponible para generar una sesión válida.")
                            .font(AppFont.oxaniumRegular(13))
                            .foregroundStyle(.white.opacity(0.82))

                        NavigationLink {
                            TrainingPreferencesView()
                        } label: {
                            Text("Ajustar equipo")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
                    }
                }
            } else {
                let nextOverallByExerciseID = Self.makeNextOverallLookup(plan: plan)
                ForEach(plan.blocks) { block in
                    WorkoutBlockCard(
                        block: block,
                        nextOverallByExerciseID: nextOverallByExerciseID
                    )
                }

                Button {
                    historyStore.registerCompletion(for: plan)
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Marcar entrenamiento completado")
                            .font(AppFont.oxaniumBold(14))
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
            }
        }
    }

    private func planSummaryCard(plan: SuggestedWorkoutPlan) -> some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top, spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(plan.title)
                            .font(AppFont.oxaniumBold(20))
                            .foregroundStyle(.white)
                        Text(plan.subtitle)
                            .font(AppFont.oxaniumRegular(13))
                            .foregroundStyle(.white.opacity(0.82))
                    }
                    Spacer(minLength: 8)
                    BrandChip(text: plan.focus.rawValue, style: .jade, shineAngle: .degrees(30))
                }

                HStack(spacing: 8) {
                    BrandChip(text: plan.goal.rawValue, style: .gold, shineAngle: .degrees(30))
                    BrandChip(text: "\(plan.estimatedMinutes) min", style: .neutral, shineAngle: .degrees(30))
                }

                Text(plan.rationale)
                    .font(AppFont.oxaniumRegular(12))
                    .foregroundStyle(.white.opacity(0.75))
            }
            .frame(maxWidth: .infinity, minHeight: ShapeTokens.rowMinHeight, alignment: .topLeading)
        }
    }

    private static func makeNextOverallLookup(
        plan: SuggestedWorkoutPlan
    ) -> [String: WorkoutExercisePrescription] {
        let flattened = plan.blocks.flatMap(\.exercises)
        guard flattened.count > 1 else { return [:] }

        var lookup: [String: WorkoutExercisePrescription] = [:]
        for index in flattened.indices {
            let nextIndex = index + 1
            guard nextIndex < flattened.count else { continue }
            lookup[flattened[index].id] = flattened[nextIndex]
        }
        return lookup
    }
}

private struct WorkoutBlockCard: View {
    let block: WorkoutPlanBlock
    let nextOverallByExerciseID: [String: WorkoutExercisePrescription]

    var body: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top, spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(block.title)
                            .font(AppFont.oxaniumBold(16))
                            .foregroundStyle(.white)

                        Text(block.subtitle)
                            .font(AppFont.oxaniumRegular(12))
                            .foregroundStyle(.white.opacity(0.74))
                    }

                    Spacer(minLength: 8)

                    if let rounds = block.rounds {
                        Text("\(rounds) rondas")
                            .font(AppFont.oxaniumBold(11))
                            .foregroundStyle(Brand.jadeGlow)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(
                                Capsule().fill(Brand.jadeGlow.opacity(0.12))
                            )
                            .overlay(
                                Capsule().stroke(Brand.borderLight, lineWidth: 0.8)
                            )
                    }
                }

                VStack(spacing: 8) {
                    ForEach(Array(block.exercises.enumerated()), id: \.element.id) { index, prescription in
                        WorkoutExerciseRow(
                            prescription: prescription,
                            flowContext: flowContext(for: index, prescription: prescription)
                        )
                    }
                }

                if let rest = block.restBetweenRounds {
                    Text("Descanso entre rondas: \(rest) segundos")
                        .font(AppFont.oxaniumRegular(12))
                        .foregroundStyle(.white.opacity(0.72))
                }
            }
        }
    }

    private func flowContext(
        for index: Int,
        prescription: WorkoutExercisePrescription
    ) -> WorkoutExerciseFlowContext {
        WorkoutExerciseFlowContext(
            blockType: block.type,
            nextExerciseInBlock: nextExerciseInBlock(for: index),
            nextExerciseOverall: nextOverallByExerciseID[prescription.id]
        )
    }

    private func nextExerciseInBlock(for index: Int) -> WorkoutExercisePrescription? {
        guard !block.exercises.isEmpty else { return nil }

        let nextIndex = index + 1
        if nextIndex < block.exercises.count {
            return block.exercises[nextIndex]
        }

        switch block.type {
        case .single:
            return nil
        case .superset, .circuit:
            return block.exercises.count > 1 ? block.exercises.first : nil
        }
    }
}

private struct WorkoutExerciseRow: View {
    let prescription: WorkoutExercisePrescription
    let flowContext: WorkoutExerciseFlowContext?

    var body: some View {
        NavigationLink {
            ExerciseDetailScreen(
                slug: prescription.exercise.slug,
                prescription: prescription,
                flowContext: flowContext
            )
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(prescription.exercise.displayName)
                            .font(AppFont.oxaniumBold(14))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)

                        Text("\(prescription.sets) series • \(prescription.repsText) • Descanso \(prescription.restSeconds)s")
                            .font(AppFont.oxaniumRegular(12))
                            .foregroundStyle(.white.opacity(0.78))
                    }

                    Spacer(minLength: 8)

                    Image(systemName: "chevron.right")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.62))
                }

                Text(prescription.notes)
                    .font(AppFont.oxaniumRegular(11))
                    .foregroundStyle(.white.opacity(0.72))

                Text(suggestedLoadText)
                    .font(AppFont.oxaniumBold(11))
                    .foregroundStyle(prescription.suggestedWeightKg == nil ? .white.opacity(0.56) : Brand.jadeGlow)

                Text(techniqueText)
                    .font(AppFont.oxaniumRegular(11))
                    .foregroundStyle(prescription.exercise.displayTechnique == nil ? .white.opacity(0.56) : .white.opacity(0.74))

                Text(prescription.progressionNote)
                    .font(AppFont.oxaniumRegular(11))
                    .foregroundStyle(.white.opacity(0.74))
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, minHeight: ShapeTokens.rowMinHeight, alignment: .topLeading)
            .background(
                RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                    .fill(Color.white.opacity(0.06))
            )
            .overlay(
                RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                    .stroke(Brand.borderLight, lineWidth: 0.8)
            )
        }
        .buttonStyle(.plain)
    }

    private var suggestedLoadText: String {
        if let weight = prescription.suggestedWeightKg {
            return "Carga sugerida: \(formatted(weight)) kg"
        }
        return "Carga sugerida: --"
    }

    private var techniqueText: String {
        if let technique = prescription.exercise.displayTechnique, !technique.isEmpty {
            return "Técnica: \(technique)"
        }
        return "Técnica: estándar"
    }
}

private func formatted(_ value: Double) -> String {
    if value.rounded() == value {
        return String(format: "%.0f", value)
    }
    return String(format: "%.1f", value)
}

#Preview {
    NavigationStack {
        SuggestedWorkoutView()
            .environmentObject(TrainingPreferencesStore())
            .environmentObject(TrainingSessionHistoryStore())
            .environmentObject(ExercisePerformanceStore())
    }
    .preferredColorScheme(.dark)
}
