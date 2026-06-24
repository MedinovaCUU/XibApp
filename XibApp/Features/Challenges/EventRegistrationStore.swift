import Foundation

struct EventRegistration: Identifiable, Codable, Hashable {
    var id: UUID
    var challengeID: UUID
    var accountID: UUID
    var accountName: String
    var accountEmail: String
    var createdAt: Date
}

enum EventRegistrationError: LocalizedError {
    case eventDataMissing
    case alreadyRegistered
    case eventIsFull(Int)

    var errorDescription: String? {
        switch self {
        case .eventDataMissing:
            return "Este evento no está disponible para registro."
        case .alreadyRegistered:
            return "Ya tienes un lugar apartado para este evento."
        case .eventIsFull(let capacity):
            return "No hay lugares disponibles. Cupo máximo: \(capacity)."
        }
    }
}

@MainActor
final class EventRegistrationStore: ObservableObject {
    @Published private(set) var registrationsByChallenge: [UUID: [EventRegistration]] = [:]

    private let storageKey = "xibapp.challenges.event.registrations.v1"

    init() {
        load()
    }

    func registrations(for challengeID: UUID) -> [EventRegistration] {
        registrationsByChallenge[challengeID] ?? []
    }

    func registeredCount(for challengeID: UUID) -> Int {
        registrations(for: challengeID).count
    }

    func isRegistered(challengeID: UUID, account: AppAccount) -> Bool {
        registrations(for: challengeID).contains { item in
            item.accountID == account.id || item.accountEmail.caseInsensitiveCompare(account.email) == .orderedSame
        }
    }

    func register(challenge: Challenge, account: AppAccount) throws {
        guard challenge.type == .event, let event = challenge.event else {
            throw EventRegistrationError.eventDataMissing
        }
        guard !isRegistered(challengeID: challenge.id, account: account) else {
            throw EventRegistrationError.alreadyRegistered
        }
        let occupied = registeredCount(for: challenge.id)
        if let totalSpots = event.totalSpots, occupied >= totalSpots {
            throw EventRegistrationError.eventIsFull(totalSpots)
        }

        let item = EventRegistration(
            id: UUID(),
            challengeID: challenge.id,
            accountID: account.id,
            accountName: account.fullName,
            accountEmail: account.email,
            createdAt: Date()
        )

        var list = registrationsByChallenge[challenge.id] ?? []
        list.append(item)
        registrationsByChallenge[challenge.id] = list
        save()
    }

    func cancel(challengeID: UUID, account: AppAccount) {
        guard var list = registrationsByChallenge[challengeID] else { return }
        list.removeAll { item in
            item.accountID == account.id || item.accountEmail.caseInsensitiveCompare(account.email) == .orderedSame
        }
        registrationsByChallenge[challengeID] = list
        save()
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            registrationsByChallenge = [:]
            return
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        registrationsByChallenge = (try? decoder.decode([UUID: [EventRegistration]].self, from: data)) ?? [:]
    }

    private func save() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        guard let data = try? encoder.encode(registrationsByChallenge) else {
            return
        }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}
