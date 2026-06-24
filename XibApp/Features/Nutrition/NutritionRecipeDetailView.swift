import SwiftUI

struct NutritionRecipeDetailView: View {
    let recipe: NutritionRecipe
    let date: Date
    @ObservedObject var progressStore: NutritionProgressStore

    private var isCompleted: Bool {
        progressStore.isCompleted(recipeID: recipe.id, on: date)
    }

    private var isFavorite: Bool {
        progressStore.isFavorite(recipeID: recipe.id)
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                ObsidianGlassCard {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(recipe.title)
                            .font(AppFont.oxaniumBold(22))
                            .foregroundStyle(.white)
                        Text(recipe.subtitle)
                            .font(AppFont.oxaniumRegular(14))
                            .foregroundStyle(.white.opacity(0.82))

                        HStack(spacing: 8) {
                            BrandChip(text: recipe.mealType.rawValue, style: .neutral)
                            BrandChip(text: "\(recipe.prepMinutes) min", style: .gold)
                            BrandChip(text: "\(recipe.servings) porción", style: .jade)
                        }

                        HStack(spacing: 8) {
                            MacroPill(title: "Cal", value: "\(recipe.macros.calories)")
                            MacroPill(title: "Prot", value: "\(recipe.macros.protein)", unit: "g")
                            MacroPill(title: "Carb", value: "\(recipe.macros.carbs)", unit: "g")
                            MacroPill(title: "Grasa", value: "\(recipe.macros.fats)", unit: "g")
                        }
                    }
                }

                ObsidianGlassCard {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredientes")
                            .font(AppFont.oxaniumBold(16))
                            .foregroundStyle(.white)

                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            Text("• \(ingredient)")
                                .font(AppFont.oxaniumRegular(13))
                                .foregroundStyle(.white.opacity(0.88))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }

                ObsidianGlassCard {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Preparación")
                            .font(AppFont.oxaniumBold(16))
                            .foregroundStyle(.white)

                        ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, step in
                            HStack(alignment: .top, spacing: 8) {
                                Text("\(index + 1).")
                                    .font(AppFont.oxaniumBold(14))
                                    .foregroundStyle(Brand.jadeGlow)
                                    .frame(width: 20, alignment: .trailing)
                                Text(step)
                                    .font(AppFont.oxaniumRegular(13))
                                    .foregroundStyle(.white.opacity(0.9))
                            }
                        }
                    }
                }

                HStack(spacing: 10) {
                    Button {
                        progressStore.toggleCompleted(recipeID: recipe.id, on: date)
                    } label: {
                        Label(isCompleted ? "Completada" : "Marcar como hecha", systemImage: isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))

                    Button {
                        progressStore.toggleFavorite(recipeID: recipe.id)
                    } label: {
                        Label(isFavorite ? "Guardada" : "Guardar", systemImage: isFavorite ? "heart.fill" : "heart")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 40)
        }
        .scrollBounceBehavior(.basedOnSize)
        .safeAreaPadding(.bottom, 8)
        .background(ObsidianBackground().ignoresSafeArea())
        .navigationTitle("Receta")
        .navigationBarTitleDisplayMode(.inline)
    }
}
