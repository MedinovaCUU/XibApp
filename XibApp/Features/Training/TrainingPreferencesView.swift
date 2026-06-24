import SwiftUI

struct TrainingPreferencesView: View {
    @EnvironmentObject private var preferencesStore: TrainingPreferencesStore

    @State private var durationValue: Double = 60

    private let equipmentColumns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        let preferences = preferencesStore.preferences

        ZStack {
            ObsidianBackground()
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 14) {
                    headerCard
                    goalCard(selectedGoal: preferences.goal)
                    splitCard(selectedSplit: preferences.split)
                    durationCard(minutes: preferences.sessionDurationMinutes)
                    equipmentCard(selectedEquipment: preferences.availableEquipment)
                    workoutStructureCard
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .navigationTitle("Preferencias")
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
        .onAppear {
            durationValue = Double(preferences.sessionDurationMinutes)
        }
    }

    private var headerCard: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 8) {
                Text("Personaliza tu recomendación")
                    .font(AppFont.oxaniumBold(20))
                    .crystalTitle()

                Text("La sugerencia usa objetivo, división, tiempo disponible y equipo real para construir tu sesión.")
                    .font(AppFont.oxaniumRegular(13))
                    .foregroundStyle(.white.opacity(0.84))
            }
        }
    }

    private func goalCard(selectedGoal: TrainingGoal) -> some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 10) {
                Text("Meta principal")
                    .font(AppFont.oxaniumBold(16))
                    .foregroundStyle(.white)

                LazyVStack(spacing: 8) {
                    ForEach(TrainingGoal.allCases) { goal in
                        SelectionRow(
                            title: goal.rawValue,
                            isSelected: goal == selectedGoal
                        ) {
                            preferencesStore.updateGoal(goal)
                        }
                    }
                }
            }
        }
    }

    private func splitCard(selectedSplit: TrainingSplit) -> some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 10) {
                Text("División preferida")
                    .font(AppFont.oxaniumBold(16))
                    .foregroundStyle(.white)

                Menu {
                    ForEach(TrainingSplit.allCases) { split in
                        Button {
                            preferencesStore.updateSplit(split)
                        } label: {
                            if split == selectedSplit {
                                Label(split.rawValue, systemImage: "checkmark")
                            } else {
                                Text(split.rawValue)
                            }
                        }
                    }
                } label: {
                    HStack(spacing: 8) {
                        Text(selectedSplit.rawValue)
                            .font(AppFont.oxaniumRegular(14))
                            .foregroundStyle(.white)
                            .lineLimit(1)
                            .truncationMode(.tail)

                        Spacer(minLength: 8)

                        Image(systemName: "chevron.up.chevron.down")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.82))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, minHeight: ShapeTokens.optionRowMinHeight, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                            .fill(Color.white.opacity(0.06))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                            .stroke(Brand.borderLight, lineWidth: 0.9)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func durationCard(minutes: Int) -> some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Duración objetivo")
                        .font(AppFont.oxaniumBold(16))
                        .foregroundStyle(.white)
                    Spacer()
                    Text("\(minutes) min")
                        .font(AppFont.oxaniumBold(14))
                        .foregroundStyle(Brand.jadeGlow)
                }

                Slider(value: $durationValue, in: 20...120, step: 5)
                    .tint(Brand.magentaCTA)
                    .onChange(of: durationValue) { newValue in
                        preferencesStore.updateDuration(Int(newValue))
                    }

                Text("La duración ajusta el número total de ejercicios y la combinación de bloques.")
                    .font(AppFont.oxaniumRegular(12))
                    .foregroundStyle(.white.opacity(0.75))
            }
        }
    }

    private func equipmentCard(selectedEquipment: Set<TrainingEquipmentOption>) -> some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 10) {
                Text("Equipo disponible")
                    .font(AppFont.oxaniumBold(16))
                    .foregroundStyle(.white)

                Text("Se recomendarán solo ejercicios cuyo equipo exista en esta lista.")
                    .font(AppFont.oxaniumRegular(12))
                    .foregroundStyle(.white.opacity(0.75))

                LazyVGrid(columns: equipmentColumns, spacing: 8) {
                    ForEach(TrainingEquipmentOption.allCases) { option in
                        EquipmentCheckboxRow(
                            title: option.rawValue,
                            isSelected: selectedEquipment.contains(option)
                        ) {
                            preferencesStore.toggleEquipment(option)
                        }
                    }
                }
            }
        }
    }

    private var workoutStructureCard: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 8) {
                Text("Lógica de supersets y circuitos")
                    .font(AppFont.oxaniumBold(16))
                    .foregroundStyle(.white)

                Text("Superset: 2 ejercicios seguidos sin descanso; descanso al cerrar la ronda.")
                    .font(AppFont.oxaniumRegular(12))
                    .foregroundStyle(.white.opacity(0.82))

                Text("Circuito: 3 o más ejercicios continuos; descanso entre rondas.")
                    .font(AppFont.oxaniumRegular(12))
                    .foregroundStyle(.white.opacity(0.82))

                Text("Descansos automáticos: pesados ~180 s, moderados ~90 s, ligeros/core ~30 s.")
                    .font(AppFont.oxaniumRegular(12))
                    .foregroundStyle(.white.opacity(0.82))
            }
        }
    }
}

private struct SelectionRow: View {
    let title: String
    let isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(isSelected ? Brand.jadeGlow : .white.opacity(0.65))

                Text(title)
                    .font(AppFont.oxaniumRegular(13))
                    .foregroundStyle(.white)

                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .frame(minHeight: ShapeTokens.optionRowMinHeight, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                    .fill(isSelected ? Brand.jadeGlow.opacity(0.14) : Color.white.opacity(0.05))
            )
            .overlay(
                RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                    .stroke(Brand.borderLight, lineWidth: 0.8)
            )
        }
        .buttonStyle(.plain)
    }
}

private struct EquipmentCheckboxRow: View {
    let title: String
    let isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(isSelected ? Brand.jadeGlow : .white.opacity(0.7))

                Text(title)
                    .font(AppFont.oxaniumRegular(12))
                    .foregroundStyle(.white.opacity(0.92))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 9)
            .frame(maxWidth: .infinity, minHeight: ShapeTokens.optionRowMinHeight, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                    .fill(isSelected ? Brand.jadeGlow.opacity(0.14) : Color.white.opacity(0.05))
            )
            .overlay(
                RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                    .stroke(Brand.borderLight, lineWidth: 0.8)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        TrainingPreferencesView()
            .environmentObject(TrainingPreferencesStore())
    }
    .preferredColorScheme(.dark)
}
