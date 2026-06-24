import Foundation

enum ChallengeType: String, CaseIterable, Identifiable, Codable {
    case promotion = "Promoción"
    case event = "Evento"
    case challenge = "Reto"

    var id: String { rawValue }
}

enum ChallengeFilter: String, CaseIterable, Identifiable {
    case all
    case promotions
    case events
    case active

    var id: String { rawValue }
}

struct ChallengeEvent: Codable, Hashable {
    var startDate: Date
    var endDate: Date?
    var location: String?
    var totalSpots: Int?
}

struct Challenge: Identifiable, Codable, Hashable {
    var id: UUID
    var title: String
    var subtitle: String
    var details: String
    var type: ChallengeType
    var imageURL: URL?
    var ctaTitle: String?
    var isFeatured: Bool
    var featuredPromotion: String?
    var event: ChallengeEvent?
    var deepLink: URL?
    var tags: [String]

    // Alias de compatibilidad para vistas antiguas.
    var image: URL? { imageURL }
    var startDate: Date? { event?.startDate }
    var endDate: Date? { event?.endDate }
    var ctaAction: (() -> Void)? { nil }

    func isActive(on date: Date = Date()) -> Bool {
        guard let event else { return true }
        if let end = event.endDate {
            return (event.startDate...end).contains(date)
        }
        return date >= event.startDate
    }
}

extension Challenge {
    static let preview: Challenge = .init(
        id: UUID(uuidString: "1F3A9F4D-4C4A-4EF2-BE95-5B28A31B4E01")!,
        title: "Reto 30 Días Core",
        subtitle: "Fortalece tu abdomen con rutinas guiadas diarias.",
        details: "Completa una sesión diaria de core durante 30 días para mejorar estabilidad y fuerza.",
        type: .challenge,
        imageURL: URL(string: "https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D/600/400"),
        ctaTitle: "Unirme",
        isFeatured: true,
        featuredPromotion: nil,
        event: nil,
        deepLink: nil,
        tags: ["Core", "Disciplina", "30 días"]
    )

    static let featuredPromotion: Challenge = .init(
        id: UUID(uuidString: "E8D60E3E-E2A0-4F8B-AE04-926F76558C62")!,
        title: "2x1 en Membresía Premium",
        subtitle: "Activa tu plan anual hoy y obtén 2 meses gratis.",
        details: "Promoción válida por tiempo limitado para nuevos usuarios en plan anual.",
        type: .promotion,
        imageURL: URL(string: "https://images.unsplash.com/photo-1734668485909-ab22515ba84f?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D/600/400"),
        ctaTitle: "Aprovechar",
        isFeatured: true,
        featuredPromotion: "2x1",
        event: nil,
        deepLink: nil,
        tags: ["Oferta", "Premium"]
    )

    static let event: Challenge = .init(
        id: UUID(uuidString: "B6ED8A20-2FE8-4A34-9E8C-E5D6E0796BA9")!,
        title: "Meetup de la Comunidad",
        subtitle: "Entrena con nosotros este sábado en el parque.",
        details: "Sesión abierta para la comunidad XibApp, con dinámica guiada y networking.",
        type: .event,
        imageURL: URL(string: "https://images.unsplash.com/photo-1554284126-aa88f22d8b74?q=80&w=1594&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D/600/400"),
        ctaTitle: "Ver detalles",
        isFeatured: false,
        featuredPromotion: nil,
        event: .init(
            startDate: Date().addingTimeInterval(60 * 60 * 24 * 3),
            endDate: Date().addingTimeInterval(60 * 60 * 24 * 3 + 60 * 90),
            location: "CDMX",
            totalSpots: 120
        ),
        deepLink: nil,
        tags: ["Comunidad", "Outdoor"]
    )

    static let samples: [Challenge] = [
        .featuredPromotion,
        .event,
        .preview
    ]

    static let demos: [Challenge] = samples
}
