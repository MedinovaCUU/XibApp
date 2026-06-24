import SwiftUI

struct GlobalRestTimerBanner: View {
    @EnvironmentObject private var restTimerStore: ActiveRestTimerStore
    var onOpenActiveExercise: () -> Void = { }

    var body: some View {
        Group {
            if restTimerStore.isRunning {
                bannerContent
                    .padding(.horizontal, 12)
                    .padding(.top, 6)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .animation(.easeInOut(duration: 0.22), value: restTimerStore.isRunning)
        .animation(.easeInOut(duration: 0.2), value: restTimerStore.isBannerCollapsed)
    }

    @ViewBuilder
    private var bannerContent: some View {
        if restTimerStore.isBannerCollapsed {
            HStack {
                Spacer(minLength: 0)
                Button {
                    restTimerStore.isBannerCollapsed = false
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "timer")
                            .font(.system(size: 12, weight: .semibold))
                        Text(formattedClock(restTimerStore.remainingSeconds))
                            .font(AppFont.oxaniumBold(12))
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(Color.black.opacity(0.7))
                    )
                    .overlay(
                        Capsule()
                            .stroke(Brand.borderLight, lineWidth: 0.8)
                    )
                }
                .buttonStyle(.plain)
            }
        } else {
            HStack(spacing: 10) {
                Button {
                    onOpenActiveExercise()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "timer")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Brand.jadeGlow)

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Descanso activo")
                                .font(AppFont.oxaniumBold(12))
                                .foregroundStyle(.white)

                            if let setNumber = restTimerStore.activeSetNumber {
                                Text("Serie \(setNumber) en progreso")
                                    .font(AppFont.oxaniumRegular(11))
                                    .foregroundStyle(.white.opacity(0.8))
                            } else {
                                Text("Mantén el ritmo")
                                    .font(AppFont.oxaniumRegular(11))
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                        }

                        Spacer(minLength: 8)

                        Text(formattedClock(restTimerStore.remainingSeconds))
                            .font(AppFont.oxaniumBold(16))
                            .foregroundStyle(Brand.jadeGlow)
                            .monospacedDigit()
                    }
                }
                .buttonStyle(.plain)

                Button {
                    restTimerStore.isBannerCollapsed = true
                } label: {
                    Image(systemName: "eye.slash")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.85))
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                    .fill(Color.black.opacity(0.72))
            )
            .overlay(
                RoundedRectangle(cornerRadius: ShapeTokens.panelCorner, style: .continuous)
                    .stroke(Brand.borderLight, lineWidth: 0.85)
            )
        }
    }

    private func formattedClock(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
