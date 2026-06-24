import SwiftUI

struct ChallengeDetailView: View {
    @EnvironmentObject private var accountSession: AccountSessionStore
    @EnvironmentObject private var eventRegistrationStore: EventRegistrationStore

    @State private var eventRegistrationMessage: String?

    let challenge: Challenge

    var body: some View {
        ZStack {
            ObsidianBackground().ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    headerImage
                    infoCard
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
    }

    private var headerImage: some View {
        ObsidianGlassCard(content: {
            VStack(alignment: .leading, spacing: 12) {
                AsyncImage(url: challenge.imageURL) { phase in
                    switch phase {
                    case .empty:
                        Color.white.opacity(0.08)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        Color.white.opacity(0.06)
                    @unknown default:
                        Color.white.opacity(0.06)
                    }
                }
                .frame(height: 220)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                Text(challenge.type.rawValue.uppercased())
                    .font(AppFont.oxaniumBold(11))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Brand.magentaCTA.opacity(0.18), in: Capsule())
                    .foregroundStyle(Brand.magentaCTA)
            }
        }, cornerRadius: 24)
    }

    private var infoCard: some View {
        ObsidianGlassCard(content: {
            VStack(alignment: .leading, spacing: 10) {
                Text(challenge.title)
                    .font(AppFont.oxaniumBold(22))
                    .foregroundStyle(.white)

                Text(challenge.subtitle)
                    .font(AppFont.oxaniumRegular(14))
                    .foregroundStyle(.white.opacity(0.85))

                Text(detailsSectionTitle)
                    .font(AppFont.oxaniumBold(13))
                    .foregroundStyle(.white)
                    .padding(.top, 2)

                Text(challenge.details)
                    .font(AppFont.oxaniumRegular(13))
                    .foregroundStyle(.white.opacity(0.82))

                if let promotion = challenge.featuredPromotion {
                    Label("Promoción: \(promotion)", systemImage: "tag.fill")
                        .font(AppFont.oxaniumRegular(13))
                        .foregroundStyle(.white)
                }

                if let event = challenge.event {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Información del evento")
                            .font(AppFont.oxaniumBold(13))
                            .foregroundStyle(.white)
                            .padding(.top, 2)

                        Text("Inicio: \(event.startDate.formatted(date: .abbreviated, time: .shortened))")
                            .font(AppFont.oxaniumRegular(12))
                            .foregroundStyle(.white.opacity(0.8))

                        if let end = event.endDate {
                            Text("Fin: \(end.formatted(date: .abbreviated, time: .shortened))")
                                .font(AppFont.oxaniumRegular(12))
                                .foregroundStyle(.white.opacity(0.8))
                        }

                        if let location = event.location {
                            Text("Ubicación: \(location)")
                                .font(AppFont.oxaniumRegular(12))
                                .foregroundStyle(.white.opacity(0.8))
                        }
                    }
                }

                eventRegistrationSection

                if !challenge.tags.isEmpty {
                    HStack(spacing: 8) {
                        ForEach(challenge.tags, id: \.self) { tag in
                            BrandChip(text: tag, style: .neutral)
                        }
                    }
                }

                if challenge.type != .event, let cta = challenge.ctaTitle {
                    Button(cta) {}
                        .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
                        .frame(maxWidth: .infinity)
                        .padding(.top, 6)
                }
            }
        }, cornerRadius: 24)
    }

    @ViewBuilder
    private var eventRegistrationSection: some View {
        if let event = challenge.event {
            let occupied = eventRegistrationStore.registeredCount(for: challenge.id)
            let account = accountSession.account
            let alreadyRegistered = account.map { currentAccount in
                eventRegistrationStore.isRegistered(challengeID: challenge.id, account: currentAccount)
            } ?? false

            VStack(alignment: .leading, spacing: 8) {
                Text("Registro para evento masivo")
                    .font(AppFont.oxaniumBold(13))
                    .foregroundStyle(.white)
                    .padding(.top, 2)

                if let totalSpots = event.totalSpots {
                    Text("Lugares apartados: \(occupied)/\(totalSpots)")
                        .font(AppFont.oxaniumRegular(12))
                        .foregroundStyle(.white.opacity(0.82))
                } else {
                    Text("Personas registradas: \(occupied)")
                        .font(AppFont.oxaniumRegular(12))
                        .foregroundStyle(.white.opacity(0.82))
                }

                if alreadyRegistered {
                    Label("Tu lugar ya está apartado", systemImage: "checkmark.seal.fill")
                        .font(AppFont.oxaniumRegular(12))
                        .foregroundStyle(Brand.jadeGlow)

                    Button {
                        cancelSpot()
                    } label: {
                        Text("Cancelar registro")
                            .font(AppFont.oxaniumRegular(13))
                            .foregroundStyle(.white.opacity(0.85))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(Color.white.opacity(0.07))
                            )
                            .overlay(
                                Capsule()
                                    .stroke(Brand.borderLight, lineWidth: 0.9)
                            )
                    }
                    .buttonStyle(.plain)
                } else {
                    Button {
                        reserveSpot()
                    } label: {
                        Text("Apartar mi lugar")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
                }

                if let eventRegistrationMessage {
                    Text(eventRegistrationMessage)
                        .font(AppFont.oxaniumRegular(12))
                        .foregroundStyle(.white.opacity(0.82))
                }
            }
        }
    }

    private var detailsSectionTitle: String {
        switch challenge.type {
        case .event:
            return "Detalles del evento"
        case .promotion:
            return "Detalles de la promoción"
        case .challenge:
            return "Detalles del reto"
        }
    }

    private func reserveSpot() {
        guard let account = accountSession.account else {
            eventRegistrationMessage = "Primero registra tu cuenta para poder apartar un lugar."
            return
        }
        do {
            try eventRegistrationStore.register(challenge: challenge, account: account)
            eventRegistrationMessage = "Listo. Tu lugar quedó apartado."
        } catch {
            eventRegistrationMessage = error.localizedDescription
        }
    }

    private func cancelSpot() {
        guard let account = accountSession.account else {
            eventRegistrationMessage = "No se encontró una cuenta activa."
            return
        }
        eventRegistrationStore.cancel(challengeID: challenge.id, account: account)
        eventRegistrationMessage = "Tu registro fue cancelado."
    }
}

#Preview {
    NavigationStack {
        ChallengeDetailView(challenge: .featuredPromotion)
    }
    .environmentObject(AccountSessionStore())
    .environmentObject(EventRegistrationStore())
}

#Preview {
    NavigationStack {
        ChallengeDetailView(challenge: .event)
    }
    .environmentObject(AccountSessionStore())
    .environmentObject(EventRegistrationStore())
}
