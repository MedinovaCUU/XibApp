import Foundation

enum HomeQuickAction: String, CaseIterable, Identifiable, Hashable {
    case routines
    case meals
    case progress
    case challenges
    case profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .routines: return "Rutina"
        case .meals: return "Comidas"
        case .progress: return "Progreso"
        case .challenges: return "Retos"
        case .profile: return "Perfil"
        }
    }

    var icon: String {
        switch self {
        case .routines: return "figure.strengthtraining.traditional"
        case .meals: return "leaf"
        case .progress: return "chart.xyaxis.line"
        case .challenges: return "flag.checkered.2.crossed"
        case .profile: return "person.crop.circle"
        }
    }
}
