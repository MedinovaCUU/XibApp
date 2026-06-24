import SwiftUI

struct ProgressHomeView: View {
    @State private var weeklyProgress: Double = 0.68
    @State private var monthlySessions: Int = 14
    @State private var currentStreak: Int = 5

    var body: some View {
        ZStack {
            ObsidianBackground()
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ObsidianGlassCard {
                        HStack(spacing: 14) {
                            ProgressRing(progress: weeklyProgress)
                                .frame(width: 82, height: 82)

                            VStack(alignment: .leading, spacing: 6) {
                                Text("Progreso semanal")
                                    .font(AppFont.oxaniumRegular(13))
                                    .foregroundStyle(.white.opacity(0.8))
                                Text("\(Int(weeklyProgress * 100))% completado")
                                    .font(AppFont.oxaniumBold(18))
                                    .foregroundStyle(.white)
                                Text("Racha actual: \(currentStreak) días")
                                    .font(AppFont.oxaniumRegular(12))
                                    .foregroundStyle(Brand.jadeGlow)
                            }
                            Spacer()
                        }
                    }

                    ObsidianGlassCard {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Resumen mensual")
                                .font(AppFont.oxaniumBold(16))
                                .foregroundStyle(.white)
                            Text("Sesiones completadas: \(monthlySessions)")
                                .font(AppFont.oxaniumRegular(13))
                                .foregroundStyle(.white.opacity(0.85))
                            Button {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                                    monthlySessions += 1
                                    weeklyProgress = min(1.0, weeklyProgress + 0.05)
                                    currentStreak += 1
                                }
                            } label: {
                                Text("Registrar entrenamiento")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(GoldGlassButtonStyle())
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .preferredColorScheme(.dark)
    }
}

