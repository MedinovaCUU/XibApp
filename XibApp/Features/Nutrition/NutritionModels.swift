import Foundation

enum MealType: String, CaseIterable, Identifiable, Codable, Hashable {
    case breakfast = "Desayuno"
    case lunch = "Comida"
    case snack = "Colación"
    case dinner = "Cena"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .breakfast: return "sun.max"
        case .lunch: return "fork.knife"
        case .snack: return "leaf"
        case .dinner: return "moon.stars"
        }
    }
}

struct NutritionMacro: Codable, Hashable {
    let calories: Int
    let protein: Int
    let carbs: Int
    let fats: Int

    static let zero = NutritionMacro(calories: 0, protein: 0, carbs: 0, fats: 0)

    static func + (lhs: NutritionMacro, rhs: NutritionMacro) -> NutritionMacro {
        NutritionMacro(
            calories: lhs.calories + rhs.calories,
            protein: lhs.protein + rhs.protein,
            carbs: lhs.carbs + rhs.carbs,
            fats: lhs.fats + rhs.fats
        )
    }
}

struct NutritionRecipe: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let mealType: MealType
    let prepMinutes: Int
    let servings: Int
    let macros: NutritionMacro
    let ingredients: [String]
    let steps: [String]
    let tags: [String]
}

struct NutritionDayPlan: Hashable {
    let date: Date
    let recipes: [NutritionRecipe]

    func recipes(for mealType: MealType) -> [NutritionRecipe] {
        recipes.filter { $0.mealType == mealType }
    }

    func consumedMacros(completedRecipeIDs: Set<String>) -> NutritionMacro {
        recipes
            .filter { completedRecipeIDs.contains($0.id) }
            .map(\.macros)
            .reduce(.zero, +)
    }
}
