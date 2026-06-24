import SwiftUI

struct NutritionHomeView: View {
    @StateObject private var viewModel = NutritionHomeViewModel()
    @StateObject private var progressStore = NutritionProgressStore()
    @State private var shoppingRecipeIDs: Set<String> = []

    var body: some View {
        ZStack {
            ObsidianBackground()
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    switch viewModel.state {
                    case .idle:
                        Color.clear
                            .frame(height: 1)

                    case .loading:
                        loadingContent

                    case .failed(let message):
                        failedContent(message: message)

                    case .loaded(let plan):
                        loadedContent(plan: plan)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 40)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .safeAreaPadding(.bottom, 8)
        .preferredColorScheme(.dark)
        .task { viewModel.loadIfNeeded() }
    }

    private var loadingContent: some View {
        VStack(spacing: 12) {
            ObsidianGlassCard {
                VStack(spacing: 10) {
                    SkeletonText(width: .infinity, height: 22)
                    SkeletonText(width: .infinity, height: 14)
                    SkeletonChips(count: 3)
                }
            }
            .redacted(reason: .placeholder)

            ForEach(0..<3, id: \.self) { _ in
                ObsidianGlassCard {
                    VStack(spacing: 10) {
                        SkeletonText(width: .infinity, height: 18)
                        SkeletonText(width: .infinity, height: 14)
                        SkeletonChips(count: 2)
                    }
                }
                .redacted(reason: .placeholder)
            }
        }
    }

    private func failedContent(message: String) -> some View {
        ObsidianGlassCard {
            VStack(alignment: .leading, spacing: 12) {
                Text("No se pudo cargar el plan de comidas")
                    .font(AppFont.oxaniumBold(18))
                    .foregroundStyle(.white)
                Text(message)
                    .font(AppFont.oxaniumRegular(13))
                    .foregroundStyle(.white.opacity(0.8))
                Button {
                    viewModel.load()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .font(.system(size: 15, weight: .semibold))
                        Text("Reintentar")
                            .font(AppFont.oxaniumBold(14))
                    }
                    .frame(maxWidth: .infinity, minHeight: 44)
                }
                .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
            }
        }
    }

    private func loadedContent(plan: NutritionDayPlan) -> some View {
        let completedIDs = progressStore.completedIDs(for: plan.date)
        let consumed = plan.consumedMacros(completedRecipeIDs: completedIDs)
        let target = viewModel.targetMacros
        let calorieProgress = min(1.0, Double(consumed.calories) / Double(max(target.calories, 1)))
        let selectedRecipes = selectedRecipes(from: plan)

        return VStack(spacing: 16) {
            ObsidianGlassCard {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Comidas del día")
                        .font(AppFont.oxaniumBold(20))
                        .foregroundStyle(.white)

                    Text("Plan práctico con recetas fáciles (MX).")
                        .font(AppFont.oxaniumRegular(13))
                        .foregroundStyle(.white.opacity(0.82))

                    HStack(spacing: 12) {
                        ProgressRing(progress: calorieProgress)
                            .frame(width: 64, height: 64)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Consumido: \(consumed.calories) / \(target.calories) kcal")
                                .font(AppFont.oxaniumBold(14))
                                .foregroundStyle(.white)
                            Text("Proteína: \(consumed.protein) / \(target.protein) g")
                                .font(AppFont.oxaniumRegular(12))
                                .foregroundStyle(.white.opacity(0.85))
                            Text("Carbos: \(consumed.carbs) / \(target.carbs) g • Grasas: \(consumed.fats) / \(target.fats) g")
                                .font(AppFont.oxaniumRegular(12))
                                .foregroundStyle(.white.opacity(0.78))
                        }
                        Spacer()
                    }

                    NavigationLink {
                        NutritionShoppingListView(recipes: selectedRecipes)
                    } label: {
                        Label(
                            selectedRecipes.isEmpty
                            ? "Selecciona platillos para tu súper"
                            : "Crear lista de compras (\(selectedRecipes.count))",
                            systemImage: "cart"
                        )
                        .frame(maxWidth: .infinity, minHeight: 44)
                    }
                    .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
                    .disabled(selectedRecipes.isEmpty)
                    .opacity(selectedRecipes.isEmpty ? 0.55 : 1)
                }
            }

            ForEach(MealType.allCases) { mealType in
                let recipes = plan.recipes(for: mealType)
                if !recipes.isEmpty {
                    ObsidianGlassCard {
                        VStack(alignment: .leading, spacing: 10) {
                            Label(mealType.rawValue, systemImage: mealType.icon)
                                .font(AppFont.oxaniumBold(16))
                                .foregroundStyle(.white)

                            ForEach(recipes) { recipe in
                                NutritionRecipeCard(
                                    recipe: recipe,
                                    isCompleted: progressStore.isCompleted(recipeID: recipe.id, on: plan.date),
                                    isFavorite: progressStore.isFavorite(recipeID: recipe.id),
                                    isSelectedForShopping: shoppingRecipeIDs.contains(recipe.id),
                                    onToggleCompleted: {
                                        progressStore.toggleCompleted(recipeID: recipe.id, on: plan.date)
                                    },
                                    onToggleFavorite: {
                                        progressStore.toggleFavorite(recipeID: recipe.id)
                                    },
                                    onToggleShoppingSelection: {
                                        toggleShoppingSelection(recipeID: recipe.id)
                                    }
                                ) {
                                    NutritionRecipeDetailView(
                                        recipe: recipe,
                                        date: plan.date,
                                        progressStore: progressStore
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private func selectedRecipes(from plan: NutritionDayPlan) -> [NutritionRecipe] {
        plan.recipes.filter { shoppingRecipeIDs.contains($0.id) }
    }

    private func toggleShoppingSelection(recipeID: String) {
        if shoppingRecipeIDs.contains(recipeID) {
            shoppingRecipeIDs.remove(recipeID)
        } else {
            shoppingRecipeIDs.insert(recipeID)
        }
    }
}
#Preview {
    NavigationStack { NutritionHomeView() }
        .environment(\.locale, Locale(identifier: "es"))
        .preferredColorScheme(.dark)
        .tint(Brand.magentaCTA)
}

