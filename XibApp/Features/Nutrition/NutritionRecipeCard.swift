import SwiftUI

struct NutritionRecipeCard<Destination: View>: View {
    let recipe: NutritionRecipe
    let isCompleted: Bool
    let isFavorite: Bool
    let isSelectedForShopping: Bool
    let onToggleCompleted: () -> Void
    let onToggleFavorite: () -> Void
    let onToggleShoppingSelection: () -> Void
    @ViewBuilder let destination: () -> Destination

    var body: some View {
        ObsidianGlassCard(content: {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    Image(systemName: recipe.mealType.icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 32, height: 32)
                        .background(Brand.jadeGlow.opacity(0.25), in: Circle())

                    VStack(alignment: .leading, spacing: 3) {
                        Text(recipe.title)
                            .font(AppFont.oxaniumBold(15))
                            .foregroundStyle(.white)
                            .lineLimit(2)
                        Text(recipe.subtitle)
                            .font(AppFont.oxaniumRegular(12))
                            .foregroundStyle(.white.opacity(0.78))
                            .lineLimit(2)
                    }
                    Spacer()
                }

                HStack(spacing: 6) {
                    BrandChip(text: "\(recipe.prepMinutes) min", style: .neutral)
                    BrandChip(text: "\(recipe.macros.calories) kcal", style: .gold)
                    BrandChip(text: "\(recipe.macros.protein)P", style: .jade)
                }

                HStack(spacing: 8) {
                    Button {
                        onToggleFavorite()
                    } label: {
                        Label(isFavorite ? "Guardada" : "Guardar", systemImage: isFavorite ? "star.fill" : "star")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))

                    Button {
                        onToggleCompleted()
                    } label: {
                        Label(isCompleted ? "Hecha" : "Marcar", systemImage: isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
                }

                HStack(spacing: 8) {
                    Button {
                        onToggleShoppingSelection()
                    } label: {
                        Label(
                            isSelectedForShopping ? "En lista" : "Agregar al súper",
                            systemImage: isSelectedForShopping ? "cart.fill" : "cart.badge.plus"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))

                    NavigationLink {
                        destination()
                    } label: {
                        HStack(spacing: 6) {
                            Text("Ver receta")
                            Image(systemName: "chevron.right")
                                .font(.system(size: 11, weight: .semibold))
                        }
                        .font(AppFont.oxaniumBold(13))
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GoldGlassButtonStyle(shape: .capsule, shineAngle: .degrees(30)))
                }
            }
        }, cornerRadius: 24)
    }
}
