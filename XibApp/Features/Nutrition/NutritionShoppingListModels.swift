import Foundation

enum ShoppingListGrouping: String, CaseIterable, Identifiable {
    case supermarketSection = "Sección"
    case recipe = "Platillo"

    var id: String { rawValue }
}

enum SupermarketSection: String, CaseIterable, Identifiable {
    case produce = "Frutas y verduras"
    case proteins = "Proteínas"
    case dairyAndEggs = "Lácteos y huevos"
    case grainsAndLegumes = "Granos y leguminosas"
    case pantryAndCondiments = "Despensa y condimentos"
    case others = "Otros"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .produce:
            return "leaf"
        case .proteins:
            return "fork.knife"
        case .dairyAndEggs:
            return "drop"
        case .grainsAndLegumes:
            return "square.grid.2x2"
        case .pantryAndCondiments:
            return "shippingbox"
        case .others:
            return "list.bullet"
        }
    }
}

struct ShoppingListIngredient: Identifiable, Hashable {
    let id: String
    let recipeID: String
    let recipeTitle: String
    let ingredientText: String
    let normalizedName: String
    let section: SupermarketSection
    let recipeOrder: Int
}

struct ShoppingListEntry: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String?
    let sourceIngredientIDs: [String]
}

struct ShoppingListGroup: Identifiable, Hashable {
    let id: String
    let title: String
    let icon: String
    let entries: [ShoppingListEntry]
}
