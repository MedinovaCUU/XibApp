import Foundation

struct AppAccount: Identifiable, Codable, Hashable {
    var id: UUID
    var fullName: String
    var email: String
    var phone: String
    var createdAt: Date
}

enum AccountValidationError: LocalizedError {
    case emptyName
    case invalidEmail

    var errorDescription: String? {
        switch self {
        case .emptyName:
            return "Ingresa tu nombre completo."
        case .invalidEmail:
            return "Ingresa un correo válido."
        }
    }
}
