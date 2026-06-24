import Foundation

protocol AccountStoreType {
    func load() -> AppAccount?
    func save(_ account: AppAccount)
    func clear()
}

struct LocalAccountStore: AccountStoreType {
    private let key = "xibapp.account.v1"

    func load() -> AppAccount? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try? decoder.decode(AppAccount.self, from: data)
    }

    func save(_ account: AppAccount) {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        guard let data = try? encoder.encode(account) else {
            return
        }
        UserDefaults.standard.set(data, forKey: key)
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

@MainActor
final class AccountSessionStore: ObservableObject {
    @Published private(set) var account: AppAccount?

    private let store: AccountStoreType

    init(store: AccountStoreType = LocalAccountStore()) {
        self.store = store
        self.account = store.load()
    }

    var hasAccount: Bool {
        account != nil
    }

    func register(fullName: String, email: String, phone: String) throws {
        let normalizedName = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let normalizedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !normalizedName.isEmpty else {
            throw AccountValidationError.emptyName
        }
        guard Self.isValidEmail(normalizedEmail) else {
            throw AccountValidationError.invalidEmail
        }

        let newAccount = AppAccount(
            id: account?.id ?? UUID(),
            fullName: normalizedName,
            email: normalizedEmail,
            phone: normalizedPhone,
            createdAt: account?.createdAt ?? Date()
        )

        store.save(newAccount)
        account = newAccount
    }

    func clearAccount() {
        store.clear()
        account = nil
    }

    private static func isValidEmail(_ email: String) -> Bool {
        let parts = email.split(separator: "@")
        guard parts.count == 2 else { return false }
        return parts[1].contains(".")
    }
}
