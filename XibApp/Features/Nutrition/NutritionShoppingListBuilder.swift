import Foundation

struct NutritionShoppingListBuilder {
    func buildIngredients(from recipes: [NutritionRecipe]) -> [ShoppingListIngredient] {
        recipes.flatMap { recipe in
            recipe.ingredients.enumerated().map { index, text in
                let normalized = normalizeIngredientName(text)
                return ShoppingListIngredient(
                    id: "\(recipe.id)-\(index)",
                    recipeID: recipe.id,
                    recipeTitle: recipe.title,
                    ingredientText: text,
                    normalizedName: normalized,
                    section: inferSection(from: normalized),
                    recipeOrder: index
                )
            }
        }
    }

    func buildGroups(
        from ingredients: [ShoppingListIngredient],
        recipes: [NutritionRecipe],
        grouping: ShoppingListGrouping
    ) -> [ShoppingListGroup] {
        switch grouping {
        case .supermarketSection:
            return buildSectionGroups(from: ingredients)
        case .recipe:
            return buildRecipeGroups(from: ingredients, recipes: recipes)
        }
    }

    private func buildSectionGroups(from ingredients: [ShoppingListIngredient]) -> [ShoppingListGroup] {
        let groupedBySection = Dictionary(grouping: ingredients, by: \.section)

        return SupermarketSection.allCases.compactMap { section in
            guard let sectionItems = groupedBySection[section], !sectionItems.isEmpty else {
                return nil
            }

            let groupedByName = Dictionary(grouping: sectionItems, by: \.normalizedName)
            let entries = groupedByName
                .sorted { lhs, rhs in lhs.key < rhs.key }
                .map { normalizedName, bucket in
                    let recipeNames = Array(Set(bucket.map(\.recipeTitle))).sorted()
                    let subtitle = recipeNames.isEmpty ? nil : "En: \(recipeNames.joined(separator: ", "))"
                    return ShoppingListEntry(
                        id: "section-\(section.rawValue)-\(normalizedName)",
                        title: normalizedName.localizedCapitalized,
                        subtitle: subtitle,
                        sourceIngredientIDs: bucket.map(\.id)
                    )
                }

            return ShoppingListGroup(
                id: "section-\(section.rawValue)",
                title: section.rawValue,
                icon: section.icon,
                entries: entries
            )
        }
    }

    private func buildRecipeGroups(
        from ingredients: [ShoppingListIngredient],
        recipes: [NutritionRecipe]
    ) -> [ShoppingListGroup] {
        let groupedByRecipe = Dictionary(grouping: ingredients, by: \.recipeID)

        return recipes.compactMap { recipe in
            guard let recipeItems = groupedByRecipe[recipe.id], !recipeItems.isEmpty else {
                return nil
            }

            let entries = recipeItems
                .sorted { lhs, rhs in lhs.recipeOrder < rhs.recipeOrder }
                .map { ingredient in
                    ShoppingListEntry(
                        id: "recipe-\(ingredient.id)",
                        title: ingredient.ingredientText,
                        subtitle: ingredient.section.rawValue,
                        sourceIngredientIDs: [ingredient.id]
                    )
                }

            return ShoppingListGroup(
                id: "recipe-\(recipe.id)",
                title: recipe.title,
                icon: recipe.mealType.icon,
                entries: entries
            )
        }
    }

    private func normalizeIngredientName(_ ingredient: String) -> String {
        var tokens = ingredient
            .lowercased()
            .replacingOccurrences(of: ",", with: " ")
            .replacingOccurrences(of: ";", with: " ")
            .replacingOccurrences(of: ".", with: " ")
            .split(whereSeparator: \.isWhitespace)
            .map(String.init)

        while let first = tokens.first, shouldDropLeadingToken(first) {
            tokens.removeFirst()
        }

        let normalized = tokens.joined(separator: " ").trimmingCharacters(in: .whitespacesAndNewlines)
        return normalized.isEmpty ? ingredient.lowercased() : normalized
    }

    private func shouldDropLeadingToken(_ token: String) -> Bool {
        let cleaned = token
            .trimmingCharacters(in: CharacterSet(charactersIn: "()."))
            .lowercased()

        if cleaned.isEmpty { return true }
        if !containsLetter(cleaned) { return true }
        if measurementTokens.contains(cleaned) { return true }
        return false
    }

    private func containsLetter(_ text: String) -> Bool {
        text.range(of: "[a-záéíóúñ]", options: .regularExpression) != nil
    }

    private func inferSection(from normalizedIngredient: String) -> SupermarketSection {
        let text = normalizedIngredient.lowercased()

        if matchesAny(text, keywords: produceKeywords) {
            return .produce
        }
        if matchesAny(text, keywords: proteinKeywords) {
            return .proteins
        }
        if matchesAny(text, keywords: dairyAndEggsKeywords) {
            return .dairyAndEggs
        }
        if matchesAny(text, keywords: grainsAndLegumesKeywords) {
            return .grainsAndLegumes
        }
        if matchesAny(text, keywords: pantryKeywords) {
            return .pantryAndCondiments
        }
        return .others
    }

    private func matchesAny(_ text: String, keywords: [String]) -> Bool {
        keywords.contains(where: { text.contains($0) })
    }

    private let measurementTokens: Set<String> = [
        "g", "gr", "kg", "ml", "l",
        "taza", "tazas",
        "cucharada", "cucharadas",
        "cucharadita", "cucharaditas",
        "pza", "pzas", "pieza", "piezas",
        "porción", "porciones",
        "de", "al", "la", "el"
    ]

    private let produceKeywords: [String] = [
        "jitomate", "tomate", "cebolla", "chile", "serrano",
        "nopal", "nopales", "aguacate", "limón", "frutos rojos",
        "verdura", "verduras", "ajo", "espinaca", "lechuga"
    ]

    private let proteinKeywords: [String] = [
        "pollo", "pescado", "filete", "pechuga",
        "res", "cerdo", "atún", "camarón"
    ]

    private let dairyAndEggsKeywords: [String] = [
        "huevo", "huevos", "yogur", "yogurt",
        "queso", "leche"
    ]

    private let grainsAndLegumesKeywords: [String] = [
        "arroz", "quinoa", "avena", "pasta", "tortilla",
        "frijol", "frijoles", "lenteja", "garbanzo", "pan"
    ]

    private let pantryKeywords: [String] = [
        "aceite", "sal", "pimienta", "comino",
        "canela", "vinagre", "salsa", "mostaza"
    ]
}
