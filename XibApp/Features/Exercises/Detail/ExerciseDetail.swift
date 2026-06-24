import SwiftUI
import AVKit

private let accent = Color(hex: "#4DC9C6")

private struct ExerciseSetLog: Identifiable, Hashable {
    let id: UUID
    let setNumber: Int
    var weightKg: Double
    var reps: Int
    var isCompleted: Bool

    init(
        id: UUID = UUID(),
        setNumber: Int,
        weightKg: Double = 20,
        reps: Int = 10,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.setNumber = setNumber
        self.weightKg = weightKg
        self.reps = reps
        self.isCompleted = isCompleted
    }
}

private struct RestOverlayGuidance {
    let headline: String
    let subtitle: String
    let nextExercise: WorkoutExercisePrescription?
    let showsTransientNextExercise: Bool

    static let standard = RestOverlayGuidance(
        headline: "Descanso en curso",
        subtitle: "Prepárate para tu siguiente serie.",
        nextExercise: nil,
        showsTransientNextExercise: false
    )
}

struct ExerciseGlassCard: View {
    @EnvironmentObject private var performanceStore: ExercisePerformanceStore
    @EnvironmentObject private var sessionProgressStore: ExerciseSessionProgressStore
    @EnvironmentObject private var restTimerStore: ActiveRestTimerStore
    @StateObject private var viewModel: ExerciseDetailViewModel

    private let exerciseSlug: String
    private let prescription: WorkoutExercisePrescription?
    private let flowContext: WorkoutExerciseFlowContext?
    private let onActiveRestAnchorChanged: (String?) -> Void

    @State private var loadedExerciseID: String?
    @State private var setLogs: [ExerciseSetLog]

    @State private var selectedRestSeconds: Int
    @State private var isRestOverlayPresented = false
    @State private var restOverlayGuidance: RestOverlayGuidance = .standard

    init(
        slug: String,
        prescription: WorkoutExercisePrescription? = nil,
        flowContext: WorkoutExerciseFlowContext? = nil,
        onActiveRestAnchorChanged: @escaping (String?) -> Void = { _ in }
    ) {
        self.exerciseSlug = slug
        self.prescription = prescription
        self.flowContext = flowContext
        self.onActiveRestAnchorChanged = onActiveRestAnchorChanged
        _setLogs = State(initialValue: ExerciseGlassCard.defaultSetLogs(from: prescription))
        _selectedRestSeconds = State(initialValue: prescription?.restSeconds ?? 90)
        _viewModel = StateObject(wrappedValue: ExerciseDetailViewModel(slug: slug))
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle:
                Color.clear.onAppear { viewModel.load() }

            case .loading:
                loadingState

            case .failed(let message):
                failedState(message: message)

            case .loaded(let exercise):
                content(exercise)
                    .onAppear { initializeSessionIfNeeded(with: exercise) }
            }
        }
        .animation(.easeInOut, value: String(describing: viewModel.state))
        .onDisappear {
            isRestOverlayPresented = false
            persistSessionProgress()
        }
        .fullScreenCover(isPresented: $isRestOverlayPresented) {
            restOverlayBackdrop
        }
        .onChange(of: isRestOverlayPresented) { isPresented in
            guard !isPresented,
                  restTimerStore.remainingSeconds > 0,
                  let activeRestSetID = restTimerStore.activeSetID
            else { return }
            onActiveRestAnchorChanged(restAnchorID(for: activeRestSetID))
        }
        .onChange(of: restTimerStore.remainingSeconds) { value in
            if value <= 0 {
                isRestOverlayPresented = false
                onActiveRestAnchorChanged(nil)
            }
        }
        .onChange(of: setLogs) { _ in
            persistSessionProgress()
        }
        .onChange(of: selectedRestSeconds) { _ in
            persistSessionProgress()
        }
    }

    private var loadingState: some View {
        ObsidianGlassCard {
            VStack(spacing: 16) {
                SkeletonMedia()
                SkeletonText(width: .infinity, height: 24)
                SkeletonChips(count: 3)
                SkeletonListLines(lines: 4)
                SkeletonMuscleRow()
                SkeletonChips(count: 2)
            }
        }
    }

    private func failedState(message: String) -> some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("No se pudo cargar el ejercicio")
                    .font(AppFont.oxaniumBold(18))
                    .textPrimary()

                Text(message)
                    .font(AppFont.oxaniumRegular(13))
                    .textSecondary()

                Button {
                    viewModel.load()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.clockwise")
                        Text("Reintentar")
                            .font(AppFont.oxaniumBold(14))
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
            }
        }
    }

    private func content(_ exercise: ExerciseDetailDTO) -> some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 16) {
                MediaView(urlString: exercise.primary_media_url, mediaType: exercise.media_type)
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: ShapeTokens.mediaCorner, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: ShapeTokens.mediaCorner)
                            .stroke(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.20), .clear, accent.opacity(0.25)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                            .blendMode(.screen)
                    )

                Text(exercise.displayName)
                    .font(Typography.title)
                    .textPrimary()
                    .lineLimit(2)

                if let technique = exercise.displayTechnique {
                    BrandChip(text: technique, style: .jade, shineAngle: .degrees(30))
                }

                if let aliases = exercise.similar_names, !aliases.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(aliases, id: \.self) { alias in
                                BrandChip(text: alias, style: .gold, shineAngle: .degrees(30))
                            }
                        }
                    }
                }

                if let steps = exercise.instructions, !steps.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        SectionHeader("Instrucciones")
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                                HStack(alignment: .top, spacing: 8) {
                                    Text("\(index + 1).")
                                        .font(Typography.stepNumber)
                                        .textSecondary()
                                        .frame(width: 22, alignment: .trailing)

                                    Text(step)
                                        .font(Typography.stepBody)
                                        .textPrimary()
                                }
                            }
                        }
                    }
                }

                if !exercise.muscles.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        SectionHeader("Músculos trabajados")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(exercise.muscles) { muscle in
                                    MuscleCard(muscle: muscle)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }

                if !exercise.equipment.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        SectionHeader("Equipo necesario")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(exercise.equipment) { eq in
                                    BrandChip(text: eq.name, style: .gold, shineAngle: .degrees(30))
                                }
                            }
                        }
                    }
                }

                trainingSessionSection
            }
        }
        .accessibilityElement(children: .contain)
    }

    private var trainingSessionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader("Registro rápido")

            HStack {
                Text("\(completedSetCount)/\(setLogs.count) series completadas")
                    .font(AppFont.oxaniumRegular(13))
                    .foregroundStyle(.white.opacity(0.84))
                Spacer()
                Text("Descanso: \(selectedRestSeconds)s")
                    .font(AppFont.oxaniumRegular(12))
                    .foregroundStyle(.white.opacity(0.72))
            }

                if let prescription {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Prescripción sugerida: \(prescription.sets) series • \(prescription.repsText)")
                            .font(AppFont.oxaniumRegular(12))
                            .foregroundStyle(.white.opacity(0.78))
                        if let suggestedWeight = prescription.suggestedWeightKg {
                            Text("Carga sugerida: \(formatWeight(suggestedWeight)) kg")
                                .font(AppFont.oxaniumBold(12))
                                .foregroundStyle(Brand.jadeGlow)
                        }
                        Text(prescription.progressionNote)
                            .font(AppFont.oxaniumRegular(11))
                            .foregroundStyle(.white.opacity(0.72))
                    }
            }

            restPresetSelector

            VStack(spacing: 10) {
                ForEach(Array(setLogs.enumerated()), id: \.element.id) { index, log in
                    let anchorID = restAnchorID(for: log.id)
                    if restTimerStore.remainingSeconds > 0, restTimerStore.activeSetID == log.id {
                        inlineRestTimerRow(for: log)
                            .id(anchorID)
                    } else {
                        ExerciseSetRow(log: $setLogs[index]) { updatedLog in
                            if updatedLog.isCompleted {
                                let isFinalSet = isCompletingCurrentExercise(with: updatedLog)
                                registerCompletedSet(updatedLog)
                                prepareRestOverlay(forFinalSet: isFinalSet)
                                startRestTimer(
                                    triggeredBySetID: updatedLog.id,
                                    triggeredBySetNumber: updatedLog.setNumber,
                                    presentOverlay: true
                                )
                            }
                        }
                        .id(anchorID)
                    }
                }
            }

            Button {
                addSet()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "plus.circle.fill")
                    Text("Agregar serie")
                        .font(AppFont.oxaniumBold(14))
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
        }
    }

    private var restPresetSelector: some View {
        HStack(spacing: 8) {
            ForEach([30, 45, 60, 90, 120, 180], id: \.self) { seconds in
                Button {
                    selectedRestSeconds = seconds
                } label: {
                    Text("\(seconds)s")
                        .font(AppFont.oxaniumRegular(12))
                        .foregroundStyle(selectedRestSeconds == seconds ? .black : .white.opacity(0.92))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            Capsule().fill(
                                selectedRestSeconds == seconds
                                ? AnyShapeStyle(Brand.magentaCTA)
                                : AnyShapeStyle(Color.white.opacity(0.08))
                            )
                        )
                        .overlay(
                            Capsule()
                                .stroke(Brand.borderLight, lineWidth: 0.9)
                        )
                }
                .buttonStyle(.plain)
            }
            Spacer()
        }
    }

    private var restOverlayBackdrop: some View {
        ZStack {
            Color.black.opacity(0.65)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeOut(duration: 0.2)) {
                        isRestOverlayPresented = false
                    }
                }

            restOverlayCard
                .padding(12)
        }
        .preferredColorScheme(.dark)
    }

    private var restOverlayCard: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()

                Button {
                    isRestOverlayPresented = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.84))
                }
                .buttonStyle(.plain)
            }

            VStack(spacing: 8) {
                Text(restOverlayGuidance.headline)
                    .font(AppFont.oxaniumBold(26))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)

                Text(restOverlayGuidance.subtitle)
                    .font(AppFont.oxaniumRegular(16))
                    .foregroundStyle(.white.opacity(0.86))
                    .multilineTextAlignment(.center)
            }

            Text(formatClock(restTimerStore.remainingSeconds))
                .font(AppFont.oxaniumBold(86))
                .foregroundStyle(Brand.jadeGlow)
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            ProgressView(
                value: Double(max(0, restTimerStore.totalSeconds - restTimerStore.remainingSeconds)),
                total: Double(max(1, restTimerStore.totalSeconds))
            )
            .tint(Brand.magentaCTA)
            .scaleEffect(x: 1, y: 1.5, anchor: .center)
            .padding(.horizontal, 6)

            if let nextExercise = restOverlayGuidance.nextExercise {
                if restOverlayGuidance.showsTransientNextExercise {
                    nextExerciseCard(
                        nextExercise,
                        title: "Siguiente ejercicio"
                    )
                    .opacity(restTimerStore.isTransientNextExerciseVisible ? 1 : 0)
                    .animation(.easeInOut(duration: 0.35), value: restTimerStore.isTransientNextExerciseVisible)
                } else {
                    nextExerciseCard(
                        nextExercise,
                        title: "Siguiente ejercicio"
                    )
                }
            }

            if restOverlayGuidance.showsTransientNextExercise && !restTimerStore.isTransientNextExerciseVisible {
                Text("Continúa al siguiente ejercicio al terminar el descanso.")
                    .font(AppFont.oxaniumRegular(13))
                    .foregroundStyle(.white.opacity(0.72))
                    .multilineTextAlignment(.center)
                    .transition(.opacity)
            }

            HStack(spacing: 10) {
                Button {
                    stopRestTimer()
                } label: {
                    Label("Saltar", systemImage: "forward.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))

                Button {
                    restTimerStore.restart()
                    isRestOverlayPresented = true
                } label: {
                    Label("Reiniciar", systemImage: "arrow.counterclockwise")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
            }
        }
        .padding(24)
        .frame(maxWidth: 560, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: ShapeTokens.cardCorner, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color.black.opacity(0.92), Brand.obsidianBottom.opacity(0.9)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: ShapeTokens.cardCorner, style: .continuous)
                .stroke(Brand.borderLight, lineWidth: 1)
        )
        .padding(.vertical, 20)
        .onTapGesture { }
    }

    private func inlineRestTimerRow(for log: ExerciseSetLog) -> some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Label("Descanso activo", systemImage: "timer")
                        .font(AppFont.oxaniumBold(13))
                        .foregroundStyle(.white)

                    Spacer(minLength: 8)

                    Text(formatClock(restTimerStore.remainingSeconds))
                        .font(AppFont.oxaniumBold(20))
                        .foregroundStyle(Brand.jadeGlow)
                }

                Text("Serie \(log.setNumber) en descanso. El temporizador sigue corriendo.")
                    .font(AppFont.oxaniumRegular(12))
                    .foregroundStyle(.white.opacity(0.8))

                ProgressView(
                    value: Double(max(0, restTimerStore.totalSeconds - restTimerStore.remainingSeconds)),
                    total: Double(max(1, restTimerStore.totalSeconds))
                )
                .tint(Brand.magentaCTA)

                HStack(spacing: 8) {
                    Button {
                        isRestOverlayPresented = true
                    } label: {
                        Label("Ver temporizador", systemImage: "arrow.up.left.and.arrow.down.right")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))

                    Button {
                        stopRestTimer()
                    } label: {
                        Text("Saltar")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
                }
            }
        }
    }

    private func nextExerciseCard(
        _ exercise: WorkoutExercisePrescription,
        title: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title.uppercased())
                .font(AppFont.oxaniumBold(12))
                .foregroundStyle(.white.opacity(0.72))

            Text(exercise.exercise.displayName)
                .font(AppFont.oxaniumBold(18))
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)

            Text("\(exercise.sets) series • \(exercise.repsText)")
                .font(AppFont.oxaniumRegular(13))
                .foregroundStyle(.white.opacity(0.82))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                .fill(Color.white.opacity(0.08))
        )
        .overlay(
            RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                .stroke(Brand.borderLight, lineWidth: 0.9)
        )
    }

    private var completedSetCount: Int {
        setLogs.filter(\.isCompleted).count
    }

    private func isCompletingCurrentExercise(with updatedLog: ExerciseSetLog) -> Bool {
        setLogs.allSatisfy { log in
            if log.id == updatedLog.id {
                return updatedLog.isCompleted
            }
            return log.isCompleted
        }
    }

    private func prepareRestOverlay(forFinalSet isFinalSet: Bool) {
        let blockType = flowContext?.blockType ?? .single
        let isComplexBlock = blockType == .superset || blockType == .circuit

        if isComplexBlock {
            let nextExercise = flowContext?.nextExerciseInBlock ?? flowContext?.nextExerciseOverall
            restOverlayGuidance = RestOverlayGuidance(
                headline: isFinalSet ? "Serie completada" : "Cambio de ejercicio",
                subtitle: nextExercise == nil
                    ? "Descansa y continúa el bloque."
                    : "Sigue con el ejercicio indicado.",
                nextExercise: nextExercise,
                showsTransientNextExercise: nextExercise != nil
            )
            return
        }

        guard isFinalSet else {
            restOverlayGuidance = .standard
            return
        }

        if let nextExercise = flowContext?.nextExerciseOverall {
            restOverlayGuidance = RestOverlayGuidance(
                headline: "Última serie completada",
                subtitle: "Recupera y prepárate para el siguiente ejercicio.",
                nextExercise: nextExercise,
                showsTransientNextExercise: false
            )
        } else {
            restOverlayGuidance = RestOverlayGuidance(
                headline: "Ejercicio completado",
                subtitle: "Excelente. Tómate el descanso y continúa.",
                nextExercise: nil,
                showsTransientNextExercise: false
            )
        }
    }

    private func restAnchorID(for setID: UUID) -> String {
        "rest-anchor-\(setID.uuidString)"
    }

    private static func defaultSetLogs(from prescription: WorkoutExercisePrescription? = nil) -> [ExerciseSetLog] {
        let setCount = max(1, prescription?.sets ?? 4)
        let reps = defaultReps(from: prescription?.repsText) ?? 10
        let weight = max(0, prescription?.suggestedWeightKg ?? 20)
        return (1...setCount).map { ExerciseSetLog(setNumber: $0, weightKg: weight, reps: reps) }
    }

    private static func defaultReps(from repsText: String?) -> Int? {
        guard let repsText else { return nil }
        let numbers = repsText
            .components(separatedBy: CharacterSet.decimalDigits.inverted)
            .compactMap(Int.init)

        guard !numbers.isEmpty else { return nil }
        if numbers.count >= 2 {
            return max(1, Int(round(Double(numbers[0] + numbers[1]) / 2.0)))
        }
        return max(1, numbers[0])
    }

    private func initializeSessionIfNeeded(with exercise: ExerciseDetailDTO) {
        guard loadedExerciseID != exercise.id else { return }
        loadedExerciseID = exercise.id
        let savedSession = sessionProgressStore.session(forSlug: exerciseSlug)

        if let savedSession, !savedSession.sets.isEmpty {
            setLogs = Self.setLogs(from: savedSession.sets)
            selectedRestSeconds = savedSession.selectedRestSeconds
        } else {
            setLogs = Self.defaultSetLogs(from: prescription)
            selectedRestSeconds = prescription?.restSeconds ?? 90
        }

        isRestOverlayPresented = false
    }

    private static func setLogs(from persistedSets: [ExerciseSetProgress]) -> [ExerciseSetLog] {
        let mapped = persistedSets
            .map { item in
                ExerciseSetLog(
                    id: item.id,
                    setNumber: max(1, item.setNumber),
                    weightKg: max(0, item.weightKg),
                    reps: max(1, item.reps),
                    isCompleted: item.isCompleted
                )
            }
            .sorted { lhs, rhs in
                if lhs.setNumber == rhs.setNumber {
                    return lhs.id.uuidString < rhs.id.uuidString
                }
                return lhs.setNumber < rhs.setNumber
            }

        return mapped.isEmpty ? defaultSetLogs() : mapped
    }

    private func persistSessionProgress() {
        let exerciseID = loadedExerciseID ?? exerciseSlug
        guard !setLogs.isEmpty else {
            sessionProgressStore.clearSession(forSlug: exerciseSlug)
            return
        }

        let persistedSets = setLogs.map { log in
            ExerciseSetProgress(
                id: log.id,
                setNumber: log.setNumber,
                weightKg: log.weightKg,
                reps: log.reps,
                isCompleted: log.isCompleted
            )
        }

        sessionProgressStore.saveSession(
            exerciseID: exerciseID,
            exerciseSlug: exerciseSlug,
            selectedRestSeconds: selectedRestSeconds,
            sets: persistedSets
        )
    }

    private func addSet() {
        let nextSet = (setLogs.last?.setNumber ?? 0) + 1
        setLogs.append(ExerciseSetLog(setNumber: nextSet))
    }

    private func registerCompletedSet(_ log: ExerciseSetLog) {
        let exerciseID = loadedExerciseID ?? exerciseSlug
        performanceStore.registerCompletedSet(
            exerciseID: exerciseID,
            exerciseSlug: exerciseSlug,
            weightKg: log.weightKg,
            reps: log.reps
        )
    }

    private func startRestTimer(
        triggeredBySetID: UUID? = nil,
        triggeredBySetNumber: Int? = nil,
        presentOverlay: Bool = true
    ) {
        if let triggeredBySetID {
            onActiveRestAnchorChanged(restAnchorID(for: triggeredBySetID))
        } else if let activeSetID = restTimerStore.activeSetID {
            onActiveRestAnchorChanged(restAnchorID(for: activeSetID))
        }

        restTimerStore.start(
            durationSeconds: selectedRestSeconds,
            setID: triggeredBySetID,
            setNumber: triggeredBySetNumber,
            exerciseSlug: exerciseSlug,
            exerciseName: prescription?.exercise.displayName ?? exerciseSlug,
            guidance: .init(
                headline: restOverlayGuidance.headline,
                subtitle: restOverlayGuidance.subtitle,
                nextExerciseName: restOverlayGuidance.nextExercise?.exercise.displayName,
                nextExerciseMeta: restOverlayGuidance.nextExercise.map { "\($0.sets) series • \($0.repsText)" },
                showsTransientNextExercise: restOverlayGuidance.showsTransientNextExercise
            )
        )
        isRestOverlayPresented = presentOverlay
    }

    private func stopRestTimer() {
        restTimerStore.skip()
        isRestOverlayPresented = false
        onActiveRestAnchorChanged(nil)
    }

    private func formatClock(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func formatWeight(_ value: Double) -> String {
        if value.rounded() == value {
            return String(format: "%.0f", value)
        }
        return String(format: "%.1f", value)
    }
}

private struct ExerciseSetRow: View {
    @Binding var log: ExerciseSetLog
    let onToggleCompletion: (ExerciseSetLog) -> Void

    var body: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Serie \(log.setNumber)")
                        .font(AppFont.oxaniumBold(14))
                        .foregroundStyle(.white)
                    Spacer()
                    Button {
                        log.isCompleted.toggle()
                        onToggleCompletion(log)
                    } label: {
                        Text(log.isCompleted ? "Completada" : "Completar")
                            .font(AppFont.oxaniumRegular(12))
                            .foregroundStyle(log.isCompleted ? .black : .white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(
                                Capsule().fill(
                                    log.isCompleted
                                    ? AnyShapeStyle(Brand.jadeGlow)
                                    : AnyShapeStyle(Color.white.opacity(0.08))
                                )
                            )
                            .overlay(
                                Capsule().stroke(Brand.borderLight, lineWidth: 0.8)
                            )
                    }
                    .buttonStyle(.plain)
                }

                HStack(spacing: 10) {
                    HStack(spacing: 6) {
                        Button {
                            log.weightKg = max(0, log.weightKg - 2.5)
                        } label: {
                            Image(systemName: "minus")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(width: 28, height: 28)
                                .background(Color.white.opacity(0.1), in: Circle())
                        }
                        .buttonStyle(.plain)

                        TextField("kg", value: $log.weightKg, format: .number.precision(.fractionLength(0...1)))
                            .keyboardType(.decimalPad)
                            .font(AppFont.oxaniumBold(14))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .frame(width: 64)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: ShapeTokens.fieldCorner, style: .continuous)
                                    .fill(Color.white.opacity(0.06))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: ShapeTokens.fieldCorner, style: .continuous)
                                    .stroke(Brand.borderLight, lineWidth: 0.8)
                            )
                            .onChange(of: log.weightKg) { newValue in
                                if newValue < 0 {
                                    log.weightKg = 0
                                }
                            }

                        Button {
                            log.weightKg += 2.5
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(width: 28, height: 28)
                                .background(Color.white.opacity(0.1), in: Circle())
                        }
                        .buttonStyle(.plain)
                    }

                    Text("kg")
                        .font(AppFont.oxaniumRegular(12))
                        .foregroundStyle(.white.opacity(0.75))

                    Spacer()

                    Stepper {
                        Text("\(log.reps) reps")
                            .font(AppFont.oxaniumBold(13))
                            .foregroundStyle(.white)
                    } onIncrement: {
                        log.reps = min(40, log.reps + 1)
                    } onDecrement: {
                        log.reps = max(1, log.reps - 1)
                    }
                    .labelsHidden()
                }
            }
        }
    }
}

private struct MediaView: View {
    let urlString: String?
    let mediaType: String?

    var body: some View {
        ZStack {
            if let urlString, let url = URL(string: urlString) {
                if (mediaType ?? "image") == "video" {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            Rectangle().fill(.white.opacity(0.06))
                        case .success(let image):
                            image.resizable().scaledToFill()
                        case .failure:
                            Rectangle().fill(.white.opacity(0.06))
                        @unknown default:
                            Rectangle().fill(.white.opacity(0.06))
                        }
                    }
                    PlayOverlay()
                } else {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            Rectangle().fill(.white.opacity(0.06))
                        case .success(let image):
                            image.resizable().scaledToFill()
                        case .failure:
                            Rectangle().fill(.white.opacity(0.06))
                        @unknown default:
                            Rectangle().fill(.white.opacity(0.06))
                        }
                    }
                }
            } else {
                Rectangle().fill(.white.opacity(0.06))
                Text("Sin imagen")
                    .font(.footnote)
                    .textSecondary()
            }
        }
        .clipped()
    }
}

private struct PlayOverlay: View {
    var body: some View {
        Circle()
            .fill(.black.opacity(0.35))
            .frame(width: 52, height: 52)
            .overlay(
                Image(systemName: "play.fill")
                    .imageScale(.large)
                    .foregroundStyle(.white)
            )
    }
}

private struct SectionHeader: View {
    let title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title.uppercased())
            .font(Typography.sectionHeader)
            .textSecondary()
            .overlay(alignment: .bottomLeading) {
                Rectangle()
                    .fill(accent.opacity(0.35))
                    .frame(height: 1)
                    .offset(y: 4)
                    .blur(radius: 0.3)
            }
    }
}

private struct MuscleCard: View {
    let muscle: MuscleDTO

    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: muscle.image_url ?? "")) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: ShapeTokens.fieldCorner).fill(.white.opacity(0.06))
                case .success(let image):
                    image.resizable().scaledToFit()
                case .failure:
                    RoundedRectangle(cornerRadius: ShapeTokens.fieldCorner).fill(.white.opacity(0.06))
                @unknown default:
                    RoundedRectangle(cornerRadius: ShapeTokens.fieldCorner).fill(.white.opacity(0.06))
                }
            }
            .frame(width: 72, height: 72)
            .clipShape(RoundedRectangle(cornerRadius: ShapeTokens.fieldCorner, style: .continuous))

            Text(muscle.name)
                .font(Typography.muscleName)
                .textSecondary()
                .lineLimit(1)
        }
        .frame(width: 80)
    }
}

struct ExerciseDetailScreen: View {
    let slug: String
    var prescription: WorkoutExercisePrescription? = nil
    var flowContext: WorkoutExerciseFlowContext? = nil

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                ExerciseGlassCard(
                    slug: slug,
                    prescription: prescription,
                    flowContext: flowContext
                ) { anchorID in
                    guard let anchorID else { return }
                    scrollToRestAnchor(anchorID, proxy: proxy)
                }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 32)
            }
        }
        .background(ObsidianBackground().ignoresSafeArea())
        .navigationTitle("Ejercicio")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func scrollToRestAnchor(_ anchorID: String, proxy: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 0.28)) {
                proxy.scrollTo(anchorID, anchor: .center)
            }
        }

        // Second pass to handle delayed layout updates after overlay dismissal.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
            withAnimation(.easeInOut(duration: 0.22)) {
                proxy.scrollTo(anchorID, anchor: .center)
            }
        }
    }
}

#Preview("Exercise Screen") {
    NavigationStack {
        ExerciseDetailScreen(slug: "press-de-banca-plano-con-barra-tecnica-base")
    }
    .environmentObject(ExercisePerformanceStore())
    .environmentObject(ExerciseSessionProgressStore())
    .environmentObject(ActiveRestTimerStore())
    .preferredColorScheme(.dark)
}

#Preview("Exercise Card - Loading State") {
    ZStack {
        ObsidianBackground().ignoresSafeArea()
        ObsidianGlassCard {
            VStack(spacing: 16) {
                SkeletonMedia()
                SkeletonText(width: .infinity, height: 24)
                SkeletonChips(count: 3)
                SkeletonListLines(lines: 4)
                SkeletonMuscleRow()
                SkeletonChips(count: 2)
            }
        }
        .padding()
    }
    .environmentObject(ExercisePerformanceStore())
    .environmentObject(ExerciseSessionProgressStore())
    .environmentObject(ActiveRestTimerStore())
    .preferredColorScheme(.dark)
}
