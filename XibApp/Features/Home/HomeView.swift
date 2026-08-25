import SwiftUI

struct MacroPlan {
    var calories: Int
    var protein: Int
    var carbs: Int
    var fats: Int
}

private let demoMacros = MacroPlan(calories: 2200, protein: 160, carbs: 230, fats: 70)

struct HomeView: View {
    @EnvironmentObject private var trainingPreferencesStore: TrainingPreferencesStore
    @EnvironmentObject private var trainingHistoryStore: TrainingSessionHistoryStore
    @EnvironmentObject private var exercisePerformanceStore: ExercisePerformanceStore

    @StateObject private var suggestionViewModel = SuggestedWorkoutViewModel()

    @State private var weeklyProgress: Double = 0.6
    @State private var streakDays: Int = 4
    @State private var showWelcome: Bool = true

    private var refreshToken: String {
        let sessionsToken = trainingHistoryStore.sessions
            .prefix(4)
            .map { "\($0.id.uuidString)-\($0.date.timeIntervalSince1970)" }
            .joined(separator: "|")

        let performanceToken = exercisePerformanceStore.snapshotsBySlug
            .values
            .sorted { $0.updatedAt > $1.updatedAt }
            .prefix(4)
            .map { "\($0.exerciseSlug)-\($0.updatedAt.timeIntervalSince1970)-\($0.lastWeightKg)-\($0.lastReps)" }
            .joined(separator: "|")

        return "\(trainingPreferencesStore.preferences.refreshKey)#\(trainingHistoryStore.sessions.count)#\(sessionsToken)#\(exercisePerformanceStore.snapshotsBySlug.count)#\(performanceToken)"
    }

    var body: some View {
        ZStack {
            ObsidianBackground()
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    header

                    if showWelcome {
                        welcomeCard
                    }

                    progressCard
                    suggestedWorkoutCard
                    macrosCard(macros: demoMacros)
                    quickActions
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .padding(.bottom, 28)
            }
        }
        .preferredColorScheme(.dark)
        .tint(Brand.magentaCTA)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(for: HomeQuickAction.self) { action in
            action.destinationView
        }
        .task(id: refreshToken) {
            suggestionViewModel.loadIfNeeded(
                preferences: trainingPreferencesStore.preferences,
                history: trainingHistoryStore.sessions,
                performanceBySlug: exercisePerformanceStore.snapshotsBySlug
            )
        }
    }

    private var header: some View {
        ObsidianGlassCard {
            HStack(spacing: 14) {
                Image("XibAppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 56, height: 56)
                    .shadow(color: .black.opacity(0.22), radius: 14, y: 8)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 4) {
                    Text("XibApp")
                        .font(AppFont.oxaniumBold(24))
                        .crystalTitle()
                    Text("Tu entrenador personalizado")
                        .font(AppFont.oxaniumRegular(15))
                        .foregroundStyle(.white.opacity(0.82))
                }
                Spacer()
                Image(systemName: "bolt.heart")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Brand.jadeGlow)
                    .frame(width: 40, height: 40)
                    .background(.ultraThinMaterial, in: Circle())
                    .overlay(Circle().stroke(Brand.borderLight, lineWidth: 0.9))
            }
        }
    }

    private var welcomeCard: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 10) {
                Text("¡Bienvenido/a!")
                    .font(AppFont.oxaniumBold(18))
                    .foregroundStyle(.white)

                Text("Ahora tu entrenamiento sugerido se construye por meta, división, equipo y duración. Puedes ajustarlo en cualquier momento.")
                    .font(AppFont.oxaniumRegular(13))
                    .foregroundStyle(.white.opacity(0.85))

                Button {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                        showWelcome = false
                    }
                } label: {
                    Text("Entendido")
                        .font(AppFont.oxaniumBold(14))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(GoldGlassButtonStyle())
            }
        }
    }

    private var progressCard: some View {
        ObsidianGlassCard {
            HStack(spacing: 16) {
                ProgressRing(progress: weeklyProgress)
                    .frame(width: 76, height: 76)

                VStack(alignment: .leading, spacing: 6) {
                    Text("Progreso semanal")
                        .font(AppFont.oxaniumRegular(14))
                        .foregroundStyle(.white.opacity(0.85))
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("\(Int(weeklyProgress * 100))% del objetivo")
                        .font(AppFont.oxaniumBold(18))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Racha: \(streakDays) días")
                        .font(AppFont.oxaniumRegular(12))
                        .foregroundStyle(Brand.jadeGlow)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .layoutPriority(1)

                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        weeklyProgress = min(1.0, weeklyProgress + 0.1)
                        streakDays += 1
                    }
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "checkmark.circle")
                        Text("Marcar hoy")
                            .font(AppFont.button(14))
                            .lineLimit(1)
                    }
                }
                .buttonStyle(GoldGlassButtonStyle())
                .frame(minWidth: 120)
            }
        }
    }

    private var suggestedWorkoutCard: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Label("Entrenamiento de hoy sugerido", systemImage: "flame.fill")
                        .font(AppFont.oxaniumBold(16))
                        .foregroundStyle(.white)
                    Spacer()
                    splitChip
                }

                suggestedWorkoutStateContent
            }
        }
    }

    @ViewBuilder
    private var splitChip: some View {
        let split = trainingPreferencesStore.preferences.split
        BrandChip(text: split.rawValue, style: .gold, shineAngle: .degrees(30))
            .font(AppFont.oxaniumRegular(11))
    }

    @ViewBuilder
    private var suggestedWorkoutStateContent: some View {
        switch suggestionViewModel.state {
        case .idle, .loading:
            VStack(alignment: .leading, spacing: 10) {
                SkeletonText(width: .infinity, height: 24)
                SkeletonChips(count: 3)
                Text("Generando sugerencia...")
                    .font(AppFont.oxaniumRegular(12))
                    .foregroundStyle(.white.opacity(0.75))
            }

        case .failed(let message):
            VStack(alignment: .leading, spacing: 10) {
                Text("No se pudo generar el entrenamiento")
                    .font(AppFont.oxaniumBold(18))
                    .foregroundStyle(.white)

                Text(message)
                    .font(AppFont.oxaniumRegular(12))
                    .foregroundStyle(.white.opacity(0.8))

                Button {
                    suggestionViewModel.retry(
                        preferences: trainingPreferencesStore.preferences,
                        history: trainingHistoryStore.sessions,
                        performanceBySlug: exercisePerformanceStore.snapshotsBySlug
                    )
                } label: {
                    Text("Reintentar")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))

                NavigationLink {
                    TrainingPreferencesView()
                } label: {
                    Text("Configurar preferencias")
                        .font(AppFont.oxaniumRegular(12))
                        .foregroundStyle(.white.opacity(0.85))
                }
            }

        case .loaded(let plan):
            VStack(alignment: .leading, spacing: 10) {
                if plan.blocks.isEmpty {
                    Text(plan.title)
                        .font(AppFont.oxaniumBold(20))
                        .foregroundStyle(.white)

                    Text("No hay ejercicios compatibles con tu equipo actual.")
                        .font(AppFont.oxaniumRegular(13))
                        .foregroundStyle(.white.opacity(0.82))
                } else {
                    NavigationLink {
                        SuggestedWorkoutView()
                    } label: {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(plan.title)
                                .font(AppFont.oxaniumBold(22))
                                .foregroundStyle(.white)

                            HStack(spacing: 8) {
                                BrandChip(text: plan.goal.rawValue, style: .jade, shineAngle: .degrees(30))
                                BrandChip(text: "\(plan.estimatedMinutes) min", style: .neutral, shineAngle: .degrees(30))
                            }

                            let previewExercises = Array(plan.blocks.flatMap(\.exercises).prefix(3))
                            if !previewExercises.isEmpty {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 8) {
                                    ForEach(previewExercises, id: \.id) { exercise in
                                        BrandChip(text: exercise.exercise.displayName, style: .jade, shineAngle: .degrees(30))
                                    }
                                }
                            }
                            }

                            HStack(spacing: 8) {
                                Image(systemName: "play.fill")
                                    .font(.system(size: 11, weight: .bold))
                                Text("Iniciar entrenamiento sugerido")
                                    .font(AppFont.oxaniumBold(14))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 11, weight: .semibold))
                            }
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                                    .fill(Color.white.opacity(0.08))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                                    .stroke(Brand.borderLight, lineWidth: 0.8)
                            )
                        }
                    }
                    .buttonStyle(.plain)
                }

                NavigationLink {
                    TrainingPreferencesView()
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "slider.horizontal.3")
                        Text("Ajustar meta, equipo y duración")
                            .font(AppFont.oxaniumRegular(12))
                    }
                    .foregroundStyle(.white.opacity(0.84))
                }
            }
        }
    }

    private func macrosCard(macros: MacroPlan) -> some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                Label("Plan de comidas de hoy", systemImage: "fork.knife")
                    .font(AppFont.oxaniumBold(16))
                    .foregroundStyle(.white)

                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 8),
                        GridItem(.flexible(), spacing: 8)
                    ],
                    spacing: 8
                ) {
                    MacroPill(title: "Calorías", value: "\(macros.calories)")
                    MacroPill(title: "Proteínas", value: "\(macros.protein)", unit: "g")
                    MacroPill(title: "Carbos", value: "\(macros.carbs)", unit: "g")
                    MacroPill(title: "Grasas", value: "\(macros.fats)", unit: "g")
                }

                NavigationLink(value: HomeQuickAction.meals) {
                    HStack(spacing: 8) {
                        Image(systemName: "list.bullet")
                        Text("Ver recetas fáciles (MX)")
                            .font(AppFont.oxaniumBold(14))
                    }
                }
                .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
            }
        }
    }

    private var quickActions: some View {
        QuickActionsSection()
    }
}

struct ProgressRing: View {
    var progress: Double

    var body: some View {
        ZStack {
            Circle().stroke(Brand.borderLight, lineWidth: 10)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Brand.jadeGlow, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Text("\(Int(progress * 100))%")
                .font(AppFont.oxaniumBold(14))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    NavigationStack { HomeView() }
        .environmentObject(TrainingPreferencesStore())
        .environmentObject(TrainingSessionHistoryStore())
        .environmentObject(ExercisePerformanceStore())
        .environment(\.locale, Locale(identifier: "es"))
        .preferredColorScheme(.dark)
        .tint(Brand.magentaCTA)
}
