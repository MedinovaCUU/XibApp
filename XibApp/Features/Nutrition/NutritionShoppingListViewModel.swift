import Foundation

@MainActor
final class NutritionShoppingListViewModel: ObservableObject {
    @Published var grouping: ShoppingListGrouping = .supermarketSection {
        didSet { rebuildGroups() }
    }
    @Published private(set) var groups: [ShoppingListGroup] = []
    @Published private(set) var checkedIngredientIDs: Set<String> = []

    private let recipes: [NutritionRecipe]
    private let ingredients: [ShoppingListIngredient]
    private let builder: NutritionShoppingListBuilder

    init(
        recipes: [NutritionRecipe],
        builder: NutritionShoppingListBuilder = NutritionShoppingListBuilder()
    ) {
        self.recipes = recipes
        self.builder = builder
        self.ingredients = builder.buildIngredients(from: recipes)
        rebuildGroups()
    }

    var recipeCount: Int {
        recipes.count
    }

    var ingredientCount: Int {
        ingredients.count
    }

    var checkedCount: Int {
        checkedIngredientIDs.count
    }

    func toggle(_ entry: ShoppingListEntry) {
        let allChecked = entry.sourceIngredientIDs.allSatisfy { checkedIngredientIDs.contains($0) }

        if allChecked {
            entry.sourceIngredientIDs.forEach { checkedIngredientIDs.remove($0) }
        } else {
            entry.sourceIngredientIDs.forEach { checkedIngredientIDs.insert($0) }
        }
    }

    func isChecked(_ entry: ShoppingListEntry) -> Bool {
        entry.sourceIngredientIDs.allSatisfy { checkedIngredientIDs.contains($0) }
    }

    private func rebuildGroups() {
        groups = builder.buildGroups(from: ingredients, recipes: recipes, grouping: grouping)
    }
}
