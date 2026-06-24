import Foundation

protocol NutritionRepositoryType {
    func fetchDayPlan(for date: Date) async throws -> NutritionDayPlan
}

enum NutritionRepositoryError: LocalizedError {
    case missingResource(name: String)
    case decodeFailure(underlying: Error)

    var errorDescription: String? {
        switch self {
        case .missingResource(let name):
            return "No se encontro el archivo de recetas: \(name).json"
        case .decodeFailure:
            return "No se pudo decodificar el archivo de recetas."
        }
    }
}

protocol NutritionRecipesDataSource {
    func fetchRecipes() throws -> [NutritionRecipe]
}

struct BundleNutritionRecipesDataSource: NutritionRecipesDataSource {
    private let bundle: Bundle
    private let resourceName: String

    init(bundle: Bundle = .main, resourceName: String = "nutrition_recipes_mx") {
        self.bundle = bundle
        self.resourceName = resourceName
    }

    func fetchRecipes() throws -> [NutritionRecipe] {
        guard let url = bundle.url(forResource: resourceName, withExtension: "json") else {
            throw NutritionRepositoryError.missingResource(name: resourceName)
        }

        let data = try Data(contentsOf: url)
        do {
            return try JSONDecoder().decode([NutritionRecipe].self, from: data)
        } catch {
            throw NutritionRepositoryError.decodeFailure(underlying: error)
        }
    }
}

final class LocalNutritionRepository: NutritionRepositoryType {
    private let dataSource: NutritionRecipesDataSource

    init(dataSource: NutritionRecipesDataSource = BundleNutritionRecipesDataSource()) {
        self.dataSource = dataSource
    }

    func fetchDayPlan(for date: Date) async throws -> NutritionDayPlan {
        try await Task.sleep(nanoseconds: 220_000_000)
        let recipes = try dataSource.fetchRecipes()
        return NutritionDayPlan(date: date, recipes: recipes)
    }
}
