import SwiftUI

struct ProfileHomeView: View {
    @EnvironmentObject private var accountSession: AccountSessionStore

    private let userLevel = "Intermedio"

    var body: some View {
        let account = accountSession.account
        let userName = account?.fullName ?? "Usuario"

        ZStack {
            ObsidianBackground()
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ObsidianGlassCard {
                        HStack(spacing: 12) {
                            Circle()
                                .fill(Brand.goldGlow.opacity(0.45))
                                .frame(width: 56, height: 56)
                                .overlay(
                                    Text(String(userName.prefix(1)))
                                        .font(AppFont.oxaniumBold(26))
                                        .foregroundStyle(.white)
                                )

                            VStack(alignment: .leading, spacing: 4) {
                                Text(userName)
                                    .font(AppFont.oxaniumBold(20))
                                    .foregroundStyle(.white)
                                if let email = account?.email, !email.isEmpty {
                                    Text(email)
                                        .font(AppFont.oxaniumRegular(12))
                                        .foregroundStyle(.white.opacity(0.82))
                                }
                                Text("Nivel \(userLevel)")
                                    .font(AppFont.oxaniumRegular(12))
                                    .foregroundStyle(.white.opacity(0.82))
                            }
                            Spacer()
                        }
                    }

                    NavigationLink {
                        AccountRegistrationView(mode: .edit)
                    } label: {
                        profileOption(icon: "person.text.rectangle", title: "Editar datos de cuenta")
                    }
                    .buttonStyle(.plain)

                    profileOption(icon: "bell", title: "Notificaciones")
                    profileOption(icon: "shield", title: "Privacidad")
                    profileOption(icon: "gearshape", title: "Configuración")
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .preferredColorScheme(.dark)
    }

    private func profileOption(icon: String, title: String) -> some View {
        ObsidianGlassCard {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 34, height: 34)
                    .background(Brand.jadeGlow.opacity(0.26), in: Circle())

                Text(title)
                    .font(AppFont.oxaniumRegular(14))
                    .foregroundStyle(.white.opacity(0.9))
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.7))
            }
        }
    }
}
