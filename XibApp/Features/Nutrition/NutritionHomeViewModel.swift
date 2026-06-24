import Foundation

@MainActor
final class NutritionHomeViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded(NutritionDayPlan)
        case failed(String)
    }

    @Published private(set) var state: State = .idle

    let targetMacros: NutritionMacro

    private let repository: NutritionRepositoryType
    private let date: Date

    init(
        date: Date = Date(),
        targetMacros: NutritionMacro = NutritionMacro(calories: 2200, protein: 160, carbs: 230, fats: 70),
        repository: NutritionRepositoryType = LocalNutritionRepository()
    ) {
        self.date = date
        self.targetMacros = targetMacros
        self.repository = repository
    }

    func loadIfNeeded() {
        if case .idle = state {
            load()
        }
    }

    func load() {
        state = .loading
        Task {
            do {
                let plan = try await repository.fetchDayPlan(for: date)
                state = .loaded(plan)
            } catch {
                state = .failed(error.localizedDescription)
            }
        }
    }
}
