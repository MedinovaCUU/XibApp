import SwiftUI

struct AccountRegistrationView: View {
    enum Mode {
        case onboarding
        case edit

        var title: String {
            switch self {
            case .onboarding: return "Crear cuenta"
            case .edit: return "Editar cuenta"
            }
        }

        var subtitle: String {
            switch self {
            case .onboarding: return "Registra tu cuenta para personalizar tu experiencia y apartar lugares en eventos."
            case .edit: return "Actualiza tus datos para tus retos, eventos y seguimiento."
            }
        }

        var ctaTitle: String {
            switch self {
            case .onboarding: return "Crear cuenta"
            case .edit: return "Guardar cambios"
            }
        }
    }

    let mode: Mode

    @EnvironmentObject private var accountSession: AccountSessionStore
    @Environment(\.dismiss) private var dismiss

    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var errorMessage: String?

    init(mode: Mode = .onboarding) {
        self.mode = mode
    }

    var body: some View {
        ZStack {
            ObsidianBackground()
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    headerCard
                    formCard
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .navigationTitle(mode.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(mode == .onboarding)
        .preferredColorScheme(.dark)
        .onAppear(perform: preloadIfNeeded)
    }

    private var headerCard: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 8) {
                Text(mode.title)
                    .font(AppFont.oxaniumBold(22))
                    .crystalTitle()
                Text(mode.subtitle)
                    .font(AppFont.oxaniumRegular(14))
                    .foregroundStyle(.white.opacity(0.85))
            }
        }
    }

    private var formCard: some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                accountField(
                    title: "Nombre completo",
                    text: $fullName,
                    keyboard: .default,
                    capitalization: .words,
                    autocorrection: false
                )

                accountField(
                    title: "Correo electrónico",
                    text: $email,
                    keyboard: .emailAddress,
                    capitalization: .never,
                    autocorrection: false
                )

                accountField(
                    title: "Teléfono (opcional)",
                    text: $phone,
                    keyboard: .phonePad,
                    capitalization: .never,
                    autocorrection: false
                )

                if let errorMessage {
                    Text(errorMessage)
                        .font(AppFont.oxaniumRegular(12))
                        .foregroundStyle(Color.red.opacity(0.9))
                        .padding(.top, 2)
                }

                Button {
                    saveAccount()
                } label: {
                    Text(mode.ctaTitle)
                        .font(AppFont.oxaniumBold(15))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
                .padding(.top, 6)
            }
        }
    }

    private func accountField(
        title: String,
        text: Binding<String>,
        keyboard: UIKeyboardType,
        capitalization: TextInputAutocapitalization,
        autocorrection: Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(AppFont.oxaniumRegular(12))
                .foregroundStyle(.white.opacity(0.8))

            TextField("", text: text)
                .keyboardType(keyboard)
                .textInputAutocapitalization(capitalization)
                .autocorrectionDisabled(!autocorrection)
                .font(AppFont.oxaniumRegular(14))
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Brand.borderLight, lineWidth: 0.9)
                )
        }
    }

    private func preloadIfNeeded() {
        guard let account = accountSession.account else { return }
        fullName = account.fullName
        email = account.email
        phone = account.phone
    }

    private func saveAccount() {
        do {
            try accountSession.register(fullName: fullName, email: email, phone: phone)
            errorMessage = nil
            if mode == .edit {
                dismiss()
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    NavigationStack {
        AccountRegistrationView()
    }
    .environmentObject(AccountSessionStore())
    .preferredColorScheme(.dark)
}
