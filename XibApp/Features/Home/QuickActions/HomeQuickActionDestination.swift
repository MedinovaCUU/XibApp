import SwiftUI

extension HomeQuickAction {
    @ViewBuilder
    var destinationView: some View {
        switch self {
        case .routines:
            RoutinesHomeView()
                .navigationTitle("Rutinas")
                .navigationBarTitleDisplayMode(.inline)
        case .meals:
            NutritionHomeView()
                .navigationTitle("Comidas")
                .navigationBarTitleDisplayMode(.inline)
        case .progress:
            ProgressHomeView()
                .navigationTitle("Progreso")
                .navigationBarTitleDisplayMode(.inline)
        case .challenges:
            ChallengesView()
                .navigationTitle("Retos")
                .navigationBarTitleDisplayMode(.inline)
        case .profile:
            ProfileHomeView()
                .navigationTitle("Perfil")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
